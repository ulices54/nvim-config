-- Claude Code: integración tipo IDE (diffs en Neovim, contexto de archivo y selección)
-- Levanta un servidor WebSocket local y escribe ~/.claude/ide/<puerto>.lock para que
-- Claude Code se conecte. Desde una terminal aparte se conecta con /ide dentro de Claude
vim.pack.add({
	{ src = "https://github.com/coder/claudecode.nvim" },
})

require("claudecode").setup({
	terminal = {
		split_side = "right",
		split_width_percentage = 0.35,
		provider = "snacks",
	},
	diff_opts = {
		layout = "vertical",
	},
})

-- Prefijo <leader>c: <leader>a ya lo usa harpoon para agregar marcas
local keymap = vim.keymap
keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude" })
keymap.set("n", "<leader>cf", "<cmd>ClaudeCodeFocus<CR>", { desc = "Focus Claude" })
keymap.set("n", "<leader>cr", "<cmd>ClaudeCode --resume<CR>", { desc = "Resume Claude" })
keymap.set("n", "<leader>cC", "<cmd>ClaudeCode --continue<CR>", { desc = "Continue Claude" })
keymap.set("n", "<leader>cm", "<cmd>ClaudeCodeSelectModel<CR>", { desc = "Select Claude model" })
keymap.set("n", "<leader>cb", "<cmd>ClaudeCodeAdd %<CR>", { desc = "Add current buffer" })
keymap.set("v", "<leader>cs", "<cmd>ClaudeCodeSend<CR>", { desc = "Send selection to Claude" })
keymap.set("n", "<leader>ca", "<cmd>ClaudeCodeDiffAccept<CR>", { desc = "Accept diff" })
keymap.set("n", "<leader>cd", "<cmd>ClaudeCodeDiffDeny<CR>", { desc = "Deny diff" })

-- Alt+c oculta/muestra el panel también desde dentro de la terminal de Claude
-- (ocultarlo no termina la sesión: el proceso sigue vivo en su buffer)
keymap.set({ "n", "t" }, "<M-c>", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude" })

-- <C-h/j/k/l> para salir del panel de Claude, igual que entre ventanas y paneles de tmux.
-- Solo en el buffer de Claude: las demás terminales (lazygit, gradle) no se ven afectadas.
-- A cambio, dentro de Claude se pierden esas teclas (p. ej. Ctrl+K borra hasta el final de
-- la línea); <C-\><C-n> sigue funcionando para pasar a modo normal
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("ClaudeCodeNavigation", { clear = true }),
	callback = function(args)
		-- El nombre es term://<cwd>//<pid>:<comando>; se revisa solo el comando para no
		-- confundir una terminal abierta en una ruta que contenga "claude" (p. ej. ~/.claude-work)
		local cmd = vim.api.nvim_buf_get_name(args.buf):match("//%d+:(.*)$") or ""
		if not cmd:match("claude") then
			return
		end
		local nav = {
			["<C-h>"] = "TmuxNavigateLeft",
			["<C-j>"] = "TmuxNavigateDown",
			["<C-k>"] = "TmuxNavigateUp",
			["<C-l>"] = "TmuxNavigateRight",
		}
		for lhs, cmd in pairs(nav) do
			keymap.set("t", lhs, "<cmd>" .. cmd .. "<CR>", { buffer = args.buf, desc = cmd })
		end
	end,
})
