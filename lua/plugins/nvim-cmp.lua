return {
	-- auto completion
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
	},
	event = "InsertEnter",
	config = function()
		local snippy = require("snippy")
		snippy.setup({
			mappings = {
				is = {
					["<tab>"] = "expand_or_advance",
					["<s-tab>"] = "previous",
				},
			},
		})

		local icons = {
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
		}

		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					snippy.expand_snippet(args.body)
				end,
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(_, vim_item)
					vim_item.menu = vim_item.kind
					vim_item.kind = icons[vim_item.kind]
					return vim_item
				end,
				expandable_indicator = true,
			},
			mapping = cmp.mapping.preset.insert({
				["<c-b>"] = cmp.mapping.scroll_docs(-4),
				["<c-f>"] = cmp.mapping.scroll_docs(4),
				["<c-space>"] = cmp.mapping.complete(),
				["<c-e>"] = cmp.mapping.abort(),
				["<cr>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{
					name = "lazydev",
					group_index = 0,
				},
				{ name = "snippy" },
			}, {
				{ name = "buffer" },
			}),
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "buffer" },
			}),
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
