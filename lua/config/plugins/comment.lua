vim.pack.add({
	{ src = "https://github.com/numtostr/comment.nvim" },
	{ src = "http://github.com/JoosepAlviste/nvim-ts-context-commentstring" },
})

local comment = require("Comment")
local ts_context = require("ts_context_commentstring.integrations.comment_nvim")

comment.setup({
	-- for commenting tsx, jsx, svelte, html files
	pre_hook = ts_context.create_pre_hook(),
})
