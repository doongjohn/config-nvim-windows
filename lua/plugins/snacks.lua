return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		bigfile = {
			enabled = true,
		},
		input = {
			prompt_pos = "left",
			icon_pos = "left",
			expand = false,
		},
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
				backdrop = false,
				position = "float",
				relative = "cursor",
				noautocmd = true,
				border = "none",
				height = 1,
				row = 1,
				col = 0,
				wo = {
					winhighlight = "NormalFloat:NormalFloat",
					cursorline = false,
				},
			},
		},
	},
}
