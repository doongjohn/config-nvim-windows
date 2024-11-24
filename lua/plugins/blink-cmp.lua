return {
	"saghen/blink.cmp",
	lazy = false,
	version = "v0.*",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		{ "saghen/blink.compat", opts = { impersonate_nvim_cmp = true } },
	},
	opts = {
		keymap = {
			preset = "enter",
			["<C-n>"] = { "show", "select_next", "fallback" },
		},
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		nerd_font_variant = "normal",
		accept = {
			expand_snippet = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
		},
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "luasnip" },
			},
			providers = {
				luasnip = {
					name = "luasnip",
					module = "blink.compat.source",
					score_offset = -3,
					opts = {
						use_show_condition = false,
						show_autosnippets = true,
					},
				},
			},
		},
		trigger = {
			completion = {
				show_on_accept_on_trigger_character = false,
				show_on_insert_on_trigger_character = false,
			},
			signature_help = { enabled = true },
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
