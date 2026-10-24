vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"astro",
		"bashls",
		"cssls",
		"emmet_ls",
		"html",
		"lua_ls",
		"marksman",
		"pyright",
		"tailwindcss",
		"ts_ls",
		"vimls",
	},
	-- stylua se instala para conform; no activarlo también como servidor LSP
	automatic_enable = {
		exclude = { "stylua" },
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"eslint_d",
		"prettier",
		"prettierd",
		"stylua",
	},
})
