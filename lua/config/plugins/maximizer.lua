-- Maximizar/restaurar el split actual (<leader>mt, <leader>mr en core/keymaps.lua)
vim.pack.add({
	{ src = "https://github.com/0x00-ketsu/maximizer.nvim" },
})

require("maximizer").setup({})
