return {
	"saghen/blink.cmp",
	lazy = false,
	version = "v0.*",
	opts = {
		keymap = {
			preset = "enter",
			["<C-n>"] = { "show", "select_next", "fallback" },
		},
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		nerd_font_variant = "normal",
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
			},
			providers = {
				lsp = { fallback_for = { "lazydev" } },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
			},
		},
		trigger = {
			completion = {
				show_on_accept_on_trigger_character = false,
				show_on_insert_on_trigger_character = false,
			},
		},
		kind_icons = {
			File = "󰈙",
			Folder = "󰉋",
			Text = "",
			Snippet = "󰆐",
			Module = "󱇙",
			Keyword = "󰌋",
			Operator = "󰆕",
			Unit = "",
			Color = "󰏘",
			Value = "󰎠",
			Variable = "󰂡",
			Constant = "󰏿",
			Reference = "",
			Function = "󰊕",
			Enum = "",
			EnumMember = "",
			Struct = "󰠲",
			Class = "󰠱",
			Interface = "",
			Field = "",
			Property = "󰜢",
			Constructor = "󰛄",
			Method = "󰆧",
			Event = "",
			TypeParameter = "",
		},
	},
}
