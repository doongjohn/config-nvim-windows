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
			accept = {
				auto_brackets = { enabled = false },
			},
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
					score_offset = 1,
				},
				path = {
					score_offset = 0,
				},
				cmdline = {
					enabled = function()
						local cmdline = vim.fn.getcmdline()
						return not (cmdline:sub(1, 1) == "!" or cmdline:sub(1, 2) == ".!")
					end,
				},
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
		appearance = {
			use_nvim_cmp_as_default = true,
		},
	},
	opts_extend = { "sources.default" },
}
