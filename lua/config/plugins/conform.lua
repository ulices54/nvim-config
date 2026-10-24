vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" }
})

local function deno_or_prettier(bufnr)
	if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
		return { "deno_fmt" }
	end
	return { "prettierd" }
end

-- .editorconfig por defecto para ktlint (estilo Android Studio + excepción para @Composable)
local ktlint_editorconfig = vim.fn.stdpath("config") .. "/ktlint/editorconfig"

local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    astro = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = deno_or_prettier,
    javascriptreact = deno_or_prettier,
    json = deno_or_prettier,
    kotlin = { "ktlint" },
    lua = { "stylua" },
    markdown = { "prettier" },
    typescript = deno_or_prettier,
    typescriptreact = deno_or_prettier,
    yaml = { "prettierd" },
  },
  formatters = {
    ktlint = {
      prepend_args = { "--editorconfig=" .. ktlint_editorconfig },
      -- ktlint sale con 1 si quedan errores que no puede corregir (p. ej. nombres);
      -- igual queremos aplicar lo que sí formateó
      exit_codes = { 0, 1 },
    },
  },
  format_on_save = function(bufnr)
    -- Kotlin se formatea después de guardar (ver abajo) para no bloquear el editor
    if vim.bo[bufnr].filetype == "kotlin" then
      return
    end
    return { lsp_format = "fallback", async = false, timeout_ms = 500 }
  end,
  -- ktlint tarda ~0.8s en arrancar la JVM: formatea en segundo plano y vuelve a guardar
  format_after_save = function(bufnr)
    if vim.bo[bufnr].filetype ~= "kotlin" then
      return
    end
    return { lsp_format = "fallback" }
  end,
})
