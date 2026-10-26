vim.pack.add({
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

local harpoon = require("harpoon")
harpoon:setup()

harpoon:extend({
	UI_CREATE = function(cx)
		-- Open file in a vertical split
		vim.keymap.set("n", "<C-v>", function()
			harpoon.ui:select_menu_item({ vsplit = true })
		end, { buffer = cx.bufnr })

		-- Open file in a horizontal split
		vim.keymap.set("n", "<C-x>", function()
			harpoon.ui:select_menu_item({ split = true })
		end, { buffer = cx.bufnr })

		-- Open file in a new tab
		vim.keymap.set("n", "<C-t>", function()
			harpoon.ui:select_menu_item({ tabedit = true })
		end, { buffer = cx.bufnr })
	end,
})

local keymap = vim.keymap
-- Add mark to harpoon
keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon add mark" })
-- Show marks list
keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon list marks" })
-- Toogle previous & next buffers stroed within Harpoon list
keymap.set("n", "<C-S-P>", function()
	harpoon:list():prev()
end, { desc = "Toggle previous buffer stored in Harpoon" })
keymap.set("n", "<C-S-N>", function()
	harpoon:list():next()
end, { desc = "Toggle next buffer stored in Harpoon" })
