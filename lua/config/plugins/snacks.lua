-- Snacks
vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
})

local snacks = require("snacks")
snacks.setup({
	-- Los valores por defecto del dashboard dependen de lazy.nvim
	-- (sección "startup" y detección de plugins de sesión), por eso se
	-- definen los botones y secciones a mano para vim.pack
	dashboard = {
		enabled = true,
		preset = {
			keys = {
				{ icon = "", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = "", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = "", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{
					icon = "",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
				},
				{ icon = "󰑐", key = "s", desc = "Restore Session", action = ":AutoSession restore" },
				{ icon = "󰒲 ", key = "u", desc = "Update Plugins", action = ":lua vim.pack.update()" },
				{ icon = "󰿅", key = "q", desc = "Quit", action = ":qa" },
			},
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			function()
				return {
					align = "center",
					text = {
						{ "⚡ Neovim loaded ", hl = "footer" },
						{ tostring(#vim.pack.get()), hl = "special" },
						{ " plugins with vim.pack", hl = "footer" },
					},
				}
			end,
		},
	},
	indent = { enabled = true },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	notify = { enabled = true },
	picker = {
		enabled = true,
		-- Snacks busca "libsqlite3.so", que solo instala el paquete de desarrollo (sqlite-devel);
		-- en Linux se usa la librería que trae cualquier sistema para el historial y la frecuencia
		db = { sqlite3_path = jit.os == "Linux" and "libsqlite3.so.0" or nil },
	},
	lazygit = {
		enabled = true,
		configure = false,
	},
})

local keymap = vim.keymap
-- Searching
keymap.set("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find files" })

keymap.set("n", "<leader>fs", function()
	Snacks.picker.grep()
end, { desc = "Grep" })

keymap.set("n", "<leader>nn", function()
	Snacks.picker.notifications()
end, { desc = "Notifications history" })

-- Lazygit
keymap.set("n", "<leader>lg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
