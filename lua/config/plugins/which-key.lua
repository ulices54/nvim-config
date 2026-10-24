vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
})

require("which-key").setup({
	preset = "modern",
	-- Nombres de los grupos de <leader>
	spec = {
		{ "<leader>e", group = "Explorer" },
		{ "<leader>f", group = "Find" },
		{ "<leader>k", group = "Kotlin/Gradle" },
		{ "<leader>l", group = "Lint/Lazygit" },
		{ "<leader>m", group = "Maximize" },
		{ "<leader>n", group = "Notifications/Highlights" },
		{ "<leader>s", group = "Splits" },
		{ "<leader>t", group = "Tabs" },
		{ "<leader>w", group = "Sessions" },
		{ "<leader>x", group = "Trouble" },
	},
})
