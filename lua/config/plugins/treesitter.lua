vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },
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
