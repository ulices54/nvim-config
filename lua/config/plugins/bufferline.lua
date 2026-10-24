vim.pack.add({
	{ src = "https://github.com/akinsho/bufferline.nvim" },
})

local bufferline = require("bufferline")

bufferline.setup({
	highlights = require("nvim-dark-ide.integrations.bufferline").get(),
	options = {
		mode = "tabs",
		themable = true,
		indicator = {
			icon = "▎", -- this should be omitted if indicator style is not 'icon'
			style = "icon", --'icon' | 'underline' | 'none',
		},
		buffer_close_icon = "󰅖",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 21,

		-- Pestañas planas como VS Code; los colores de la integración de nvim-dark-ide
		-- están pensados para este estilo (con "slant"/"slope" no se dibuja el indicador)
		separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
	},
})
