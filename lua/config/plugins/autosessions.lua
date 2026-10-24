vim.pack.add({
  { src = "https://github.com/rmagatti/auto-session" },
})

local autosessions = require("auto-session")

autosessions.setup({
  auto_restore = false,
  suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
})

local keymap = vim.keymap
-- Usa el picker disponible (snacks/telescope) o vim.ui.select
keymap.set("n", "<leader>wr", "<cmd>AutoSession search<CR>", { desc = "Session search" })
keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session" })
keymap.set("n", "<leader>wa", "<cmd>AutoSession toggle<CR>", { desc = "Toggle autosave" })
