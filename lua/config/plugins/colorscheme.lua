vim.pack.add({
	{ src = "https://github.com/ulices54/nvim-dark-ide.nvim" },
})

require("nvim-dark-ide").setup({
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = { italic = true },
	},
})

vim.cmd.colorscheme("nvim-dark-ide") -- o "nvim-dark-ide-soft"
