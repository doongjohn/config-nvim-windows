return {
  -- color scheme
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require 'kanagawa'.setup {
      compile = true,
      commentStyle = { bold = false, italic = false },
      keywordStyle = { bold = false, italic = false },
      statementStyle = { bold = false, italic = false },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local palette = colors.palette

        return {
          -- treesitter
          ['@module'] = { link = '@keyword.import' },
          ['@field'] = { link = '@variable.member' },
          ['@variable.parameter'] = { fg = palette.oldWhite },
        }
      end,
    }

    vim.o.background = 'dark'
    vim.cmd.colorscheme('kanagawa-wave')

    -- semantic highlighting: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
    vim.api.nvim_set_hl(0, '@lsp.type.comment', { link = '@comment' })
    vim.api.nvim_set_hl(0, '@lsp.type.keyword', { link = '@keyword' })
    vim.api.nvim_set_hl(0, '@lsp.type.variable', { link = '@variable' })
    vim.api.nvim_set_hl(0, '@lsp.typemod.method.readonly.cpp', { link = '@function.method' })

    -- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316?permalink_comment_id=4534819#dealing-with-ambiguity
    vim.api.nvim_create_autocmd('LspTokenUpdate', {
      group = 'config',
      callback = function(args)
        local token = args.data.token

        if token.type == 'variable' then
          if token.modifiers.static then
            vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, 'Constant')
          end
        end

        if token.type == 'method' then
          if token.modifiers.defaultLibrary then
            vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id,
              '@lsp.typemod.method.defaultLibrary')
          end
        end
      end,
    })
  end
}
