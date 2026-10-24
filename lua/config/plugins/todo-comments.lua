vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
})

local todo_comments = require("todo-comments")
--
-- set keymaps
local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>ft", function()
	Snacks.picker.todo_comments()
end, { desc = "Todo comments" })

keymap.set("n", "]t", function()
	todo_comments.jump_next()
end, { desc = "Next todo comment" })

keymap.set("n", "[t", function()
	todo_comments.jump_prev()
end, { desc = "Previous todo comment" })

todo_comments.setup()
