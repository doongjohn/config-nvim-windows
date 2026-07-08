return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	cmd = { "Gitsigns" },
	keys = {
		{ "]c", "<cmd>Gitsigns next_hunk<cr>" },
		{ "[c", "<cmd>Gitsigns prev_hunk<cr>" },
	},
	opts = {
		current_line_blame = false,
	},
}
