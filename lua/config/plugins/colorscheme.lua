-- Colorschemes
-- Se instalan dos temas y ambos se configuran con fondo transparente para que se vea
-- el blur de la terminal (KDE). El que se carga al inicio se elige al final del archivo;
-- también se puede cambiar en cualquier momento con :colorscheme <nombre>
vim.pack.add({
	{ src = "https://github.com/ulices54/nvim-dark-ide.nvim" },
	{ src = "https://github.com/catppuccin/nvim" },
})

-- nvim-dark-ide (tema por defecto): variantes "nvim-dark-ide" y "nvim-dark-ide-soft"
require("nvim-dark-ide").setup({
	-- Sin fondo en el editor, los números de línea y la columna de signos
	transparent = true,
	-- Cursivas en comentarios, palabras clave y funciones
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = { italic = true },
	},
	-- El tema solo quita el fondo de Normal/gutter con transparent = true;
	-- aquí también se quita a las ventanas flotantes (nvim-tree flotante, snacks)
	-- y al menú de autocompletado (Pmenu / blink-cmp) para que se vea el blur de KDE.
	-- La línea seleccionada (PmenuSel, CursorLine de los pickers) conserva su color
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
			-- Los grupos que son link heredan el fondo del grupo al que apuntan
			if hl[group] and not hl[group].link then
				hl[group].bg = "NONE"
			end
		end
		-- Las ventanas de snacks usan estos grupos como fondo; se enlazan a NormalFloat
		-- para que también queden transparentes
		hl.SnacksNormal = { link = "NormalFloat" }
		hl.SnacksPicker = { link = "NormalFloat" }
	end,
})

-- catppuccin (tema alternativo): variantes latte, frappe, macchiato y mocha
require("catppuccin").setup({
	-- Variante que usa :colorscheme catppuccin
	flavour = "mocha",

	-- Sin fondo en el editor; también deja sin fondo el menú de autocompletado
	-- (Pmenu / blink-cmp) y nvim-tree en modo panel
	transparent_background = true,
	-- Ventanas flotantes sin fondo (nvim-tree flotante, snacks picker/notifier/lazygit).
	-- solid = false mantiene los bordes visibles en lugar de bordes del color del fondo
	float = {
		transparent = true,
		solid = false,
	},

	-- Usa mocha aunque background sea "light" (las demás variantes se eligen por nombre)
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
	-- Cursivas en comentarios, condicionales y palabras clave
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		keywords = { "italic" },
	},
	-- Detecta los plugins instalados (lualine, bufferline, blink.cmp, noice, snacks,
	-- nvim-tree, which-key, etc.) y les aplica los colores del tema
	auto_integrations = true,
})

-- Tema que se carga al iniciar: deja descomentada solo una de las dos líneas
vim.cmd.colorscheme("nvim-dark-ide") -- o "nvim-dark-ide-soft"
-- vim.cmd.colorscheme("catppuccin")
