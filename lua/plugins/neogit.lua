return {
	"neogitorg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"esmuellert/codediff.nvim",
	},
	cmd = "Neogit",
	opts = {
		integrations = {
			codediff = true,
		},
		diff_viewer = "codediff",
	},
}
