-- Colorea (), [], {} por nivel de anidación como el
-- bracket pair colorization de VS Code
vim.pack.add({
	{ src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
})

require("rainbow-delimiters.setup").setup({
	-- Solo corchetes en JSX/TSX, sin etiquetas
	-- (ver after/queries/javascript/rainbow-parens.scm)
	query = {
		javascript = "rainbow-parens",
		tsx = "rainbow-parens",
		-- HTML sin etiquetas; el JS/CSS de <script>/<style> sigue coloreado
		-- (ver queries/html/rainbow-brackets.scm)
		html = "rainbow-brackets",
	},
	highlight = {
		"RainbowDelimiterYellow",
		"RainbowDelimiterViolet",
		"RainbowDelimiterBlue",
	},
})
