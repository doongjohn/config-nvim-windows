return {
  -- lsp
  'neovim/nvim-lspconfig',
  dependencies = {
    'smiteshp/nvim-navic',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local lsp = require 'lspconfig'

    lsp.util.default_config.on_attach = function(client, bufnr)
      -- lsp breadcrumbs
      if client.server_capabilities.documentSymbolProvider then
        require 'nvim-navic'.attach(client, bufnr)
      end

      -- golang: generate a synthetic semanticTokensProvider (https://github.com/golang/go/issues/54531).
      if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
        local semantic = client.config.capabilities.textDocument.semanticTokens
        client.server_capabilities.semanticTokensProvider = {
          full = true,
          legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
          range = true,
        }
      end
    end

    -- vscode-langservers-extracted
    lsp.jsonls.setup {}
    lsp.html.setup {}
    lsp.cssls.setup {}
    lsp.eslint.setup {}

    -- scripting languages
    lsp.lua_ls.setup {
      settings = {
        Lua = {
          telemetry = {
            enable = false,
          },
        },
      },
    }
    lsp.pyright.setup {}
    lsp.nushell.setup {}
    lsp.gdscript.setup {}

    -- compiled languages
    lsp.clangd.setup {
      cmd = {
        'clangd',
        '--background-index',
        '--header-insertion=never',
        '--clang-tidy',
      },
    }
    lsp.rust_analyzer.setup {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = false,
          }
        }
      },
    }
    lsp.gopls.setup {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          gofumpt = true,
          staticcheck = true,
          semanticTokens = true,
        }
      },
    }
    lsp.nimls.setup {}
    lsp.crystalline.setup {}
    lsp.zls.setup {
      cmd = { 'zigscient' },
    }
    lsp.ols.setup {}

    -- web dev
    lsp.emmet_ls.setup {}
    lsp.ts_ls.setup {}
    lsp.denols.setup {
      settings = {
        deno = {
          enable = true,
          suggest = {
            imports = {
              hosts = {
                ['https://deno.land'] = true
              }
            }
          }
        }
      },
      root_dir = function(filename, _)
        local is_deno_project = lsp.util.root_pattern('deno.json', 'deno.jsonc')(filename);
        if is_deno_project then
          return nil;
        end
        return lsp.util.root_pattern('package.json')(filename);
      end,
      single_file_support = false,
    }
    lsp.astro.setup {}

    -- shader langauges
    lsp.glsl_analyzer.setup {}
  end
}
