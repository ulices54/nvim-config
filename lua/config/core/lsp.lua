-- Deno: usa el binario `deno` del sistema (~/.deno/bin), no hace falta Mason.
-- La config de nvim-lspconfig solo se adjunta si hay deno.json/deno.jsonc/deno.lock,
-- y ts_ls se excluye solo en esos proyectos.
vim.lsp.enable("denols")

-- Kotlin: servidor oficial de JetBrains (basado en IntelliJ), instalado a mano en
-- ~/.local/share/kotlin-lsp porque la URL del paquete de Mason da 404.
-- Para actualizar: descargar el .tar.gz de https://github.com/Kotlin/kotlin-lsp/releases y extraerlo ahí.
local kotlin_server =
	vim.fn.glob(vim.fn.expand("~/.local/share/kotlin-lsp/kotlin-server-*/bin/intellij-server"), false, true)
-- kotlin-lsp no trae el plugin de Compose, así que marca "Function name should start with a
-- lowercase letter" en los @Composable. Se descarta ese aviso solo si la función tiene @Composable.
local function is_composable_naming(bufnr, diagnostic)
	if diagnostic.code ~= "FunctionName" or not vim.api.nvim_buf_is_loaded(bufnr) then
		return false
	end
	local line = diagnostic.range.start.line
	local lines = vim.api.nvim_buf_get_lines(bufnr, math.max(0, line - 4), line + 1, false)
	return table.concat(lines, "\n"):find("@Composable") ~= nil
end

local function without_composable_naming(handler, get_bufnr, key)
	return function(err, result, ctx, config)
		if result and result[key] then
			local bufnr = get_bufnr(result, ctx)
			result[key] = vim.tbl_filter(function(d)
				return not is_composable_naming(bufnr, d)
			end, result[key])
		end
		return handler(err, result, ctx, config)
	end
end

if #kotlin_server > 0 then
	vim.lsp.config("kotlin_lsp", {
		cmd = { kotlin_server[#kotlin_server], "--stdio" },
		handlers = {
			["textDocument/publishDiagnostics"] = without_composable_naming(
				vim.lsp.diagnostic.on_publish_diagnostics,
				function(result)
					return vim.uri_to_bufnr(result.uri)
				end,
				"diagnostics"
			),
			["textDocument/diagnostic"] = without_composable_naming(vim.lsp.diagnostic.on_diagnostic, function(_, ctx)
				return ctx.bufnr
			end, "items"),
		},
	})
	vim.lsp.enable("kotlin_lsp")
end

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
