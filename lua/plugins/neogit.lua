return {
	"neogitorg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	cmd = "Neogit",
	opts = {
		integrations = {
			diffview = true,
		},
	},
}
