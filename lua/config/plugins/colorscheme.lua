-- vim.pack.add({
-- 	{ src = "https://github.com/rebelot/kanagawa.nvim" },
-- })
-- vim.cmd.colorscheme("kanagawa")

vim.pack.add({
	{ src = "https://github.com/ulices54/nvim-dark-ide.nvim" },
})
-- Para desarrollar el tema localmente, usar en lugar de vim.pack.add:
-- vim.opt.rtp:prepend(vim.fn.expand("~/Proyectos/umetal/nvim-dark-ide.nvim"))

require("nvim-dark-ide").setup({
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = { italic = true },
	},
})

vim.cmd.colorscheme("nvim-dark-ide") -- o "nvim-dark-ide-soft"
