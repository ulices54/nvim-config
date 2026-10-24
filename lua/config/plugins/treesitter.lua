-- vim.pack no tiene `build`: actualizar los parsers cuando se actualiza el plugin.
-- (En una instalación nueva, treesitter.install() de abajo instala los parsers.)
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local treesitter = require("nvim-treesitter")
local ensure_installed = {
	"astro",
	"bash",
	"c",
	"css",
	"diff",
	"git_config",
	"git_rebase",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"kotlin",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"regex",
	"toml",
	"tsx",
	"typescript",
	"xml",
	"yaml",
}

treesitter.install(ensure_installed)

-- Activar Treesitter para los archivos que tengan
-- un parser disponible.
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local filetype = vim.bo[args.buf].filetype
		local lang = vim.treesitter.language.get_lang(filetype)

		if not lang then
			return
		end

		pcall(vim.treesitter.start, args.buf, lang)
	end,
})
