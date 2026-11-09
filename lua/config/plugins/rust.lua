-- Atajos de Cargo e inlay hints para proyectos Rust.
local function cargo(task)
	return function()
		local root = vim.fs.root(0, { "Cargo.toml" })
		if not root then
			vim.notify("No se encontró Cargo.toml en el proyecto", vim.log.levels.WARN)
			return
		end
		vim.cmd("botright split | resize 15")
		vim.cmd.terminal(string.format("cd %s && cargo %s", vim.fn.shellescape(root), task))
	end
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("RustCargo", { clear = true }),
	pattern = { "rust" },
	callback = function(ev)
		local opts = function(desc)
			return { buffer = ev.buf, desc = desc }
		end
		vim.keymap.set("n", "<leader>rr", cargo("run"), opts("Cargo: run"))
		vim.keymap.set("n", "<leader>rb", cargo("build"), opts("Cargo: build"))
		vim.keymap.set("n", "<leader>rc", cargo("check"), opts("Cargo: check"))
		vim.keymap.set("n", "<leader>rt", cargo("test"), opts("Cargo: test"))
		vim.keymap.set("n", "<leader>rl", cargo("clippy"), opts("Cargo: clippy"))
		vim.keymap.set("n", "<leader>rh", function()
			local filter = { bufnr = ev.buf }
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
		end, opts("Alternar inlay hints"))
	end,
})
