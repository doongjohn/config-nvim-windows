return {
	"doongjohn/glance.nvim",
	cmd = { "Glance" },
	keys = {
		{ "<f12>", "<cmd>Glance definitions<cr>" },
	},
	opts = {
		preview_win_opts = {
			cursorline = true,
			number = true,
			wrap = false,
		},
	},
}
