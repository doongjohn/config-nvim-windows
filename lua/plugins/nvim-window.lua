return {
	-- window picker
	"yorickpeterse/nvim-window",
	event = "VeryLazy",
	keys = {
		{
			"<leader>w",
			function()
				require("nvim-window").pick()
			end,
		},
	},
	opts = {
		normal_hl = "CursorLine",
		hint_hl = "Bold",
		border = "none",
	},
}
