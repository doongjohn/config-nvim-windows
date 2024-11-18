return {
	-- statusline
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	opts = {
		options = {
			globalstatus = true,
			component_separators = { left = "│", right = "│" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				-- filetype
			},
		},
	},
}
