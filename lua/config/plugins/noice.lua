vim.pack.add({
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
})

local noice = require("noice")
noice.setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	presets = {
		bottom_search = false, -- la búsqueda (/ y ?) también en popup
		command_palette = true, -- cmdline y su menú de completado juntos arriba
		long_message_to_split = true, -- mensajes largos en un split
		lsp_doc_border = true, -- borde en hover y signature help
	},
})
