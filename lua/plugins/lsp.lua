return {
  -- lsp
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'smiteshp/nvim-navic',
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
    local lsp = require 'lspconfig'
    local lsp_defaults = lsp.util.default_config
    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, capabilities)

    -- lsp breadcrumbs
    local navic = require 'nvim-navic'

    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    -- scripting languages
    do
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

      lsp.pyright.setup {
        on_attach = on_attach,
      }

      lsp.nushell.setup {
        on_attach = on_attach,
      }

      lsp.neocmake.setup {
        on_attach = on_attach,
      }
    end

    -- compiled languages
    do
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
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = false,
            }
          }
        },
        on_attach = on_attach,
      }

      lsp.gopls.setup {
        cmd = { 'gopls', 'serve' },
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
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          -- Generate a synthetic semanticTokensProvider (https://github.com/golang/go/issues/54531).
          if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
              range = true,
            }
          end
        end,
      }

      lsp.nimls.setup {
        on_attach = on_attach,
      }

      lsp.crystalline.setup {
        on_attach = on_attach,
      }

      lsp.zls.setup {
        on_attach = on_attach,
      }

      lsp.ols.setup {
        on_attach = on_attach,
      }
    end

    -- web dev
    do
      lsp.emmet_ls.setup {}

      lsp.tsserver.setup {
        on_attach = on_attach,
      }

      lsp.denols.setup {
        settings = {
          deno = {
            enable = true,
            suggest = {
              imports = {
                hosts = {
                  ["https://deno.land"] = true
                }
              }
            }
          }
        },
        root_dir = function(filename, _)
          local is_deno_project = lsp.util.root_pattern("deno.json", "deno.jsonc")(filename);
          if is_deno_project then
            return nil;
          end
          return lsp.util.root_pattern("package.json")(filename);
        end,
        single_file_support = false,
        on_attach = on_attach,
      }

      lsp.astro.setup {
        on_attach = on_attach,
      }
    end

    -- vscode-langservers-extracted
    do
      lsp.jsonls.setup {
        on_attach = on_attach,
      }

      lsp.html.setup {
        on_attach = on_attach,
      }

      lsp.cssls.setup {
        on_attach = on_attach,
      }

      lsp.eslint.setup {}
    end

    -- others
    do
      lsp.glsl_analyzer.setup {
        on_attach = on_attach,
      }
    end
  end
}
