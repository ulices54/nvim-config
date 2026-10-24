-- Deno: usa el binario `deno` del sistema (~/.deno/bin), no hace falta Mason.
-- La config de nvim-lspconfig solo se adjunta si hay deno.json/deno.jsonc/deno.lock,
-- y ts_ls se excluye solo en esos proyectos.
vim.lsp.enable("denols")

-- Símbolos de diagnóstico en la columna de signos (gutter).
-- Desde Neovim 0.10 se definen en vim.diagnostic.config; sign_define ya no aplica.
local severity = vim.diagnostic.severity
vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
	severity_sort = true, -- si hay varios en una línea, mostrar el más grave
})
