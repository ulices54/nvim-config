vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" }
})

local function deno_or_prettier(bufnr)
	if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
		return { "deno_fmt" }
	end
	return { "prettierd" }
end

local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    astro = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = deno_or_prettier,
    javascriptreact = deno_or_prettier,
    json = deno_or_prettier,
    lua = { "stylua" },
    markdown = { "prettier" },
    typescript = deno_or_prettier,
    typescriptreact = deno_or_prettier,
    yaml = { "prettierd" },
  },
  format_on_save = {
    lsp_format = "fallback",
    async = false,
    timeout_ms = 500,
  },
})
