-- Configura lua_ls para archivos de Neovim: API de `vim`, tipos de vim.uv
-- y los plugins que se importan con require()
vim.pack.add({
	{ src = "https://github.com/folke/lazydev.nvim" },
})

require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})
