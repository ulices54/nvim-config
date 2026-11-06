vim.pack.add({
	{ src = "https://github.com/ulices54/nvim-dark-ide.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
})

require("nvim-dark-ide").setup({
	transparent = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = { italic = true },
	},
	-- El tema solo quita el fondo de Normal/gutter con transparent = true;
	-- aquí también se quita a las ventanas flotantes (nvim-tree flotante, snacks)
	-- y al menú de autocompletado (Pmenu / blink-cmp) para que se vea el blur de KDE
	on_highlights = function(hl)
		local transparent_groups = {
			-- Ventanas flotantes (nvim-tree, snacks picker/notifier/lazygit)
			"NormalFloat",
			"FloatBorder",
			"FloatTitle",
			"FloatFooter",
			"NvimTreeEndOfBuffer",
			-- Menú de autocompletado
			"Pmenu",
			"PmenuKind",
			"PmenuExtra",
			"PmenuSbar",
			"BlinkCmpMenuBorder",
			"BlinkCmpScrollBarGutter",
			"BlinkCmpDocSeparator",
		}
		for _, group in ipairs(transparent_groups) do
			if hl[group] and not hl[group].link then
				hl[group].bg = "NONE"
			end
		end
		hl.SnacksNormal = { link = "NormalFloat" }
		hl.SnacksPicker = { link = "NormalFloat" }
	end,
})

require("catppuccin").setup({
	flavour = "mocha",

	transparent_background = true,
	-- Ventanas flotantes sin fondo (nvim-tree flotante, snacks picker/notifier/lazygit)
	float = {
		transparent = true,
		solid = false,
	},

	background = {
		light = "mocha",
		dark = "mocha",
	},
	-- Desactivado: pinta las ventanas sin foco (NormalNC) con un fondo sólido aunque
	-- transparent_background esté activo, y al abrir una flotante (nvim-tree, snacks)
	-- todo el editor de atrás se vuelve opaco
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		keywords = { "italic" },
	},
	-- transparent_background también deja sin fondo el menú de autocompletado (Pmenu / blink-cmp)
	auto_integrations = true,
})

vim.cmd.colorscheme("nvim-dark-ide") -- o "nvim-dark-ide-soft"
-- vim.cmd.colorscheme("catppuccin")
