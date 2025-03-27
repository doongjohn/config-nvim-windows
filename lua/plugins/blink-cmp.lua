return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "UIEnter",
	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "enter",
		},
		completion = {
			documentation = { auto_show = false },
			ghost_text = { enabled = true },
		},
		sources = {
			default = { "lazydev", "lsp", "snippets", "buffer", "path" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 1100,
				},
				lsp = {
					score_offset = 1000,
					fallbacks = {},
				},
				snippets = {
					score_offset = 990,
				},
				buffer = {
					score_offset = 980,
				},
				path = {
					score_offset = 970,
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
