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
