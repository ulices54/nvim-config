vim.pack.add({
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
})

local tiny_inline = require("tiny-inline-diagnostic")
tiny_inline.setup({
	options = {
		multilines = {
			enabled = true,
		},
		show_source = {
			enabled = true,
		},
	},
})

vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
