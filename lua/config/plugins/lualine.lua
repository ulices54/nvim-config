vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

local lualine = require("lualine")

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "│", right = "│" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icon = "",
				separator = { left = "", right = "" },
			},
		},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = {
			-- noice oculta el mensaje "recording @q" (cmdheight = 0), así que se muestra aquí
			{
				function()
					return "recording @" .. vim.fn.reg_recording()
				end,
				cond = function()
					return vim.fn.reg_recording() ~= ""
				end,
				color = "WarningMsg",
			},
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- Actualizar la barra al empezar/terminar una macro (lualine refresca cada 1s)
vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	group = vim.api.nvim_create_augroup("LualineRecording", { clear = true }),
	callback = function()
		vim.schedule(lualine.refresh)
	end,
})
