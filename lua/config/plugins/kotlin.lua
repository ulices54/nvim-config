-- Atajos de Gradle para proyectos Kotlin/Android.
-- La compilación pesada, el debug y los previews de Compose se quedan en Android Studio.
local function gradle(task)
	return function()
		local root = vim.fs.root(0, { "gradlew" })
		if not root then
			vim.notify("No se encontró gradlew en el proyecto", vim.log.levels.WARN)
			return
		end
		vim.cmd("botright split | resize 15")
		vim.cmd.terminal(string.format("cd %s && ./gradlew %s", vim.fn.shellescape(root), task))
	end
end

-- Si el archivo no terminaba en salto de línea (noeol), conform le pasa el texto a ktlint sin él,
-- ktlint lo agrega, y al guardar Neovim pone otro: queda una línea en blanco extra al final.
-- Neovim agrega ese salto al escribir de todos modos ('fixeol'), así que se marca antes.
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("KotlinFixEol", { clear = true }),
	pattern = { "*.kt", "*.kts" },
	callback = function(ev)
		if vim.bo[ev.buf].fixeol then
			vim.bo[ev.buf].eol = true
		end
	end,
})

-- kotlin-lsp no reporta los imports sin usar, así que se pintan en gris como en Android Studio.
-- Es una heurística por texto: el import se considera usado si su nombre (o su alias) aparece
-- en cualquier otra parte del archivo. No es un diagnóstico: no hay signo ni mensaje.
local unused_imports_ns = vim.api.nvim_create_namespace("kotlin_unused_imports")

-- Funciones que se usan por convención de operador (`by remember`, `a + b`, `for (x in y)`...)
-- sin escribir su nombre; se tratan siempre como usadas para no marcarlas por error.
local operator_names = {}
for _, name in ipairs({
	"getValue", "setValue", "provideDelegate", "invoke", "get", "set", "contains", "iterator",
	"next", "hasNext", "compareTo", "equals", "rangeTo", "rangeUntil", "not", "inc", "dec",
	"unaryPlus", "unaryMinus", "plus", "minus", "times", "div", "rem",
	"plusAssign", "minusAssign", "timesAssign", "divAssign", "remAssign",
}) do
	operator_names[name] = true
end

local function highlight_unused_imports(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end
	vim.api.nvim_buf_clear_namespace(bufnr, unused_imports_ns, 0, -1)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local imports, body = {}, {}
	for i, line in ipairs(lines) do
		local path, alias = line:match("^%s*import%s+([%w_.`]+)%s+as%s+([%w_`]+)")
		path = path or line:match("^%s*import%s+([%w_.`]+)")
		if path then
			-- Los imports con * terminan en "." aquí y no se pueden comprobar
			local name = (alias or path:match("([^.]+)$") or ""):gsub("`", "")
			if name ~= "" and not operator_names[name] and not name:match("^component%d+$") then
				table.insert(imports, { lnum = i - 1, name = name })
			end
		elseif not line:match("^%s*package%s") then
			table.insert(body, line)
		end
	end
	local text = table.concat(body, "\n")
	for _, import in ipairs(imports) do
		if not text:find("%f[%w_]" .. vim.pesc(import.name) .. "%f[^%w_]") then
			vim.api.nvim_buf_set_extmark(bufnr, unused_imports_ns, import.lnum, 0, {
				end_row = import.lnum,
				end_col = #lines[import.lnum + 1],
				hl_group = "DiagnosticUnnecessary",
				priority = 200, -- por encima de treesitter y semantic tokens
			})
		end
	end
end

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("KotlinUnusedImports", { clear = true }),
	pattern = { "*.kt", "*.kts" },
	callback = function(ev)
		highlight_unused_imports(ev.buf)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("KotlinGradle", { clear = true }),
	pattern = { "kotlin" },
	callback = function(ev)
		local opts = function(desc)
			return { buffer = ev.buf, desc = desc }
		end
		vim.keymap.set("n", "<leader>kb", gradle("assembleDebug"), opts("Gradle: assembleDebug"))
		vim.keymap.set("n", "<leader>ki", gradle("installDebug"), opts("Gradle: installDebug (dispositivo/emulador)"))
		vim.keymap.set("n", "<leader>kt", gradle("test"), opts("Gradle: test"))
		vim.keymap.set("n", "<leader>kl", gradle("lint"), opts("Gradle: Android lint"))
		vim.keymap.set("n", "<leader>ks", vim.lsp.buf.workspace_symbol, opts("Buscar símbolo en el workspace"))
	end,
})
