return {
	"saghen/blink.cmp",
	enabled = false, -- https://github.com/Saghen/blink.cmp/issues/923
	version = "1.*",
	event = "VeryLazy",
	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "enter",
		},
		completion = {
			trigger = {
				show_on_accept_on_trigger_character = false,
			},
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
					opts = { tailwind_color_icon = "" },
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
						return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9.,'<>%-]*!")
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
