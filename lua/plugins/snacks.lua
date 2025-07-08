return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		bigfile = { enabled = true },
		input = { enabled = true },
		picker = {
			sources = {
				files = {
					hidden = true,
					ignored = true,
					exclude = Config.search_get_exclude(),
				},
				lines = {
					win = {
						preview = {
							wo = {
								winbar = "",
							},
						},
					},
				},
			},
			layout = {
				preset = "default",
				layout = {
					backdrop = false,
				},
			},
		},
		styles = {
			input = {
				position = "float",
				relative = "cursor",
				height = 1,
				row = 1,
				col = 0,
				border = "none",
				wo = {
					winhighlight = "NormalFloat:NormalFloat",
					cursorline = false,
				},
			},
		},
	},
}
