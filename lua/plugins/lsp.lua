return {
  -- lsp
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mrded/nvim-lsp-notify',
    'smiteshp/nvim-navic',
    'folke/neodev.nvim',
  },
  init = function()
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = false,
    })

    -- disable diagnostic icon in the sign column
    vim.fn.sign_define('DiagnosticSignError',
      { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = 'DiagnosticError' })
    vim.fn.sign_define('DiagnosticSignWarn',
      { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = 'DiagnosticWarn' })
    vim.fn.sign_define('DiagnosticSignInfo',
      { text = '', texthl = 'DiagnosticSignInfo', linehl = '', numhl = 'DiagnosticInfo' })
    vim.fn.sign_define('DiagnosticSignHint',
      { text = '', texthl = 'DiagnosticSignHint', linehl = '', numhl = 'DiagnosticHint' })
  end,
  config = function()
    -- nvim lua config support
    require 'neodev'.setup {}

    local lsp = require 'lspconfig'
    local lsp_defaults = lsp.util.default_config
    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, capabilities)

    local lsp_notify_loaded = false

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- lsp progress
        if not lsp_notify_loaded then
          require 'lsp-notify'.setup {
            notify = require 'notify'
          }
          lsp_notify_loaded = true
        end
      end,
    })

    local navic = require 'nvim-navic'

    local on_attach = function(client, bufnr)
      -- lsp breadcrumbs
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    lsp.neocmake.setup {
      on_attach = on_attach,
    }

    lsp.clangd.setup {
      cmd = {
        'clangd',
        '--background-index',
        '--header-insertion=never',
        '--clang-tidy',
      },
      on_attach = on_attach,
    }

    lsp.rust_analyzer.setup {
      on_attach = on_attach,
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = false,
          }
        }
      }
    }

    lsp.gopls.setup {
      cmd = { 'gopls', 'serve' },
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        -- Generate a synthetic semanticTokensProvider (https://github.com/golang/go/issues/54531).
        if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
          client.server_capabilities.semanticTokensProvider = {
            full = true,
            legend = {
              tokenTypes = { 'namespace', 'type', 'class', 'enum', 'interface', 'struct', 'typeParameter', 'parameter', 'variable', 'property', 'enumMember', 'event', 'function', 'method', 'macro', 'keyword', 'modifier', 'comment', 'string', 'number', 'regexp', 'operator', 'decorator' },
              tokenModifiers = { 'declaration', 'definition', 'readonly', 'static', 'deprecated', 'abstract', 'async', 'modification', 'documentation', 'defaultLibrary' },
            },
          }
        end
      end,
      settings = {
        -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-config
        gopls = {
          analyses = {
            unusedparams = true,
          },
          gofumpt = true,
          semanticTokens = true,
          staticcheck = true,
        }
      },
    }

    lsp.emmet_ls.setup {
      on_attach = on_attach,
    }

    lsp.cssls.setup {
      on_attach = on_attach,
    }

    lsp.tsserver.setup {
      on_attach = on_attach,
      single_file_support = true,
    }

    lsp.astro.setup {
      on_attach = on_attach,
      init_options = {
        typescript = {
          -- -- fd -H tsserver
          -- serverPath = '/home/doongjohn/.local/share/pnpm/global/5/.pnpm/typescript@4.9.5/node_modules/typescript/lib/tsserverlibrary.js',
        },
      },
    }

    lsp.lua_ls.setup {
      settings = {
        Lua = {
          telemetry = {
            enable = false,
          },
        },
      },
      on_attach = on_attach,
    }

    lsp.racket_langserver.setup {
      on_attach = on_attach,
    }
  end
}
