vim.pack.add({
	{ src = "https://github.com/xzbdmw/colorful-menu.nvim" },
})

require("colorful-menu").setup({
	ls = {
		lua_ls = {
			-- Maybe you want to dim arguments a bit.
			arguments_hl = "@comment",
		},
		-- for lsp_config or typescript-tools
		ts_ls = {
			-- false means do not include any extra info,
			-- see https://github.com/xzbdmw/colorful-menu.nvim/issues/42
			extra_info_hl = "@comment",
		},
		zls = {
			-- Similar to the same setting of gopls.
			align_type_to_right = true,
		},
		roslyn = {
			extra_info_hl = "@comment",
		},
		-- If true, try to highlight "not supported" languages.
		fallback = true,
		-- this will be applied to label description for unsupport languages
		fallback_extra_info_hl = "@comment",
	},
	-- If the built-in logic fails to find a suitable highlight group for a label,
	-- this highlight is applied to the label.
	fallback_highlight = "@variable",
	-- If provided, the plugin truncates the final displayed text to
	-- this width (measured in display cells). Any highlights that extend
	-- beyond the truncation point are ignored. When set to a float
	-- between 0 and 1, it'll be treated as percentage of the width of
	-- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
	-- Default 60.
	max_width = 60,
})
