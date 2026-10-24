vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-lint" },
})

local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint_d" },
	kotlin = { "ktlint" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}

-- Mismo .editorconfig por defecto que usa conform para formatear
table.insert(lint.linters.ktlint.args, 1, "--editorconfig=" .. vim.fn.stdpath("config") .. "/ktlint/editorconfig")

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function(args)
		-- En proyectos Deno el linter lo provee denols
		if vim.fs.root(args.buf, { "deno.json", "deno.jsonc", "deno.lock" }) then
			return
		end
		-- En Kotlin, ktlint va por su propio autocmd (abajo)
		if vim.bo[args.buf].filetype == "kotlin" then
			return
		end
		lint.try_lint()
	end,
})

-- ktlint arranca una JVM en cada ejecución (~0.8s), así que en Kotlin no corre en cada
-- InsertLeave/BufEnter: se espera 1s sin cambios antes de lanzarlo. Mientras tanto se borran
-- sus avisos, porque tras editar ya apuntan a líneas equivocadas.
local ktlint_ns = lint.get_namespace("ktlint")
local ktlint_timer = vim.uv.new_timer()

local function schedule_ktlint(bufnr)
	ktlint_timer:stop()
	ktlint_timer:start(
		1000,
		0,
		vim.schedule_wrap(function()
			-- En modo insert se espera al InsertLeave
			if vim.fn.mode() == "i" or not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end
			if vim.api.nvim_get_current_buf() == bufnr then
				lint.try_lint("ktlint")
			end
		end)
	)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	pattern = { "*.kt", "*.kts" },
	callback = function(args)
		schedule_ktlint(args.buf)
		if args.event == "BufReadPost" and not vim.b[args.buf].ktlint_attached then
			vim.b[args.buf].ktlint_attached = true
			vim.api.nvim_buf_attach(args.buf, false, {
				on_lines = function(_, bufnr)
					vim.schedule(function()
						vim.diagnostic.reset(ktlint_ns, bufnr)
					end)
					schedule_ktlint(bufnr)
				end,
			})
		end
	end,
})

vim.keymap.set("n", "<leader>l", function()
	lint.try_lint()
end, { desc = "Trigger linting for current file" })
