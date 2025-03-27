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
			default = { "lsp", "buffer", "snippets", "path" },
			providers = {
				lsp = {
					fallbacks = {},
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
