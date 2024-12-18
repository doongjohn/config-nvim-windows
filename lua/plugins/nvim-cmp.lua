return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp",
	},
	lazy = false,
	config = function()
		local kind_icons = {
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
					vim.snippet.expand(args.body)
				end,
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(_, vim_item)
					vim_item.menu = vim_item.kind
					vim_item.kind = kind_icons[vim_item.kind]
					return vim_item
				end,
				expandable_indicator = true,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{
					name = "lazydev",
					group_index = 0,
				},
			}, {
				{ name = "buffer" },
			}, {
				{ name = "path" },
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
