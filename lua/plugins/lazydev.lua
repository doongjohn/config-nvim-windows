return {
	"folke/lazydev.nvim",
	ft = "lua",
	dependencies = {
		"bilal2453/luvit-meta",
	},
	opts = {
		library = {
			{ path = "luvit-meta/library", words = { "uv" } },
		},
	},
}
