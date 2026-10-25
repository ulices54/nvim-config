vim.pack.add({
	{ src = "https://github.com/ulices54/nvim-dark-ide.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
})

require("nvim-dark-ide").setup({
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = { italic = true },
	},
})

require("catppuccin").setup({
	flavour = "mocha",
	background = {
		light = "mocha",
		dark = "mocha",
	},
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		keywords = { "italic" },
	},
	auto_integrations = true,
})

-- vim.cmd.colorscheme("nvim-dark-ide") -- o "nvim-dark-ide-soft"
vim.cmd.colorscheme("catppuccin")
