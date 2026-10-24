vim.pack.add({
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
})

require("todo-comments").setup({})

require("trouble").setup({
	focus = true,
})

local keymap = vim.keymap.set

keymap("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open trouble workspace diagnostics" })
keymap(
	"n",
	"<leader>xd",
	"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
	{ desc = "Open trouble document diagnostics" }
)
keymap("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Open trouble quickfix list" })
keymap("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Open trouble location list" })
keymap("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "Open todos in trouble" })
