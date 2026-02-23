return {
	"neogitorg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	cmd = "Neogit",
	opts = {
		integrations = {
			codediff = true,
		},
		diff_viewer = "codediff",
	},
}
