return {
  -- auto completion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'dcampos/nvim-snippy',
    'dcampos/cmp-snippy',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
  },
  config = function()
    local cmp = require 'cmp'
    local cmp_icons = {
      Text = "",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "󰛄",
      Field = "",
      Variable = "󰂡",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "󰆐",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          require 'snippy'.expand_snippet(args.body)
        end
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, vim_item)
          vim_item.menu = vim_item.kind
          vim_item.kind = cmp_icons[vim_item.kind]
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'snippy' },
      }, {
        { name = 'buffer' },
      }),
    }

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })
  end
}
