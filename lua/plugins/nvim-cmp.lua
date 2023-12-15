---@diagnostic disable: missing-fields
return {
  -- auto completion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'rcarriga/cmp-dap',
    'dcampos/nvim-snippy',
    'dcampos/cmp-snippy',
  },
  config = function()
    local cmp = require 'cmp'
    local cmp_icons = {
      File = '󰈙',
      Folder = '󰉋',
      Text = '',
      Snippet = '󰆐',
      Module = '󱇙',
      Keyword = '󰌋',
      Operator = '󰆕',
      Unit = '',
      Color = '󰏘',
      Value = '󰎠',
      Variable = '󰂡',
      Constant = '󰏿',
      Reference = '',
      Function = '󰊕',
      Enum = '',
      EnumMember = '',
      Struct = '󰠲',
      Class = '󰠱',
      Interface = '',
      Field = '',
      Property = '󰜢',
      Constructor = '󰛄',
      Method = '󰆧',
      Event = '',
      TypeParameter = '',
    }

    cmp.setup {
      enabled = function()
        return vim.api.nvim_get_option_value('buftype', { buf = 0 }) ~= 'prompt'
            or require 'cmp_dap'.is_dap_buffer()
      end,
      snippet = {
        expand = function(args)
          require 'snippy'.expand_snippet(args.body)
        end
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
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

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
      sources = {
        { name = 'dap' },
      },
    })
  end
}
