return {
  -- color scheme
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local kanagawa = require 'kanagawa'
    kanagawa.setup {
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
        local theme = colors.theme
        local palette = colors.palette

        return {
          WinSeparator = { fg = palette.sumiInk4 },
          FloatBorder = { bg = palette.sumiInk0, fg = palette.sumiInk0 },
          -- popup menu
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          -- telescope
          TelescopeNormal = { bg = palette.sumiInk0 },
          TelescopeTitle = { bg = palette.sumiInk5, fg = palette.dragonBlue, bold = true },
          TelescopeResultsTitle = { bg = palette.sumiInk2, fg = palette.dragonBlue },
          TelescopeBorder = { bg = palette.sumiInk0, fg = palette.sumiInk0 },
          TelescopePromptPrefix = { bg = palette.sumiInk4, fg = palette.autumnRed },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          TelescopeSelection = { bg = palette.sumiInk5 },
          -- neotree
          NeoTreeNormal = { bg = palette.sumiInk0, fg = palette.fujiWhite },
          -- navbuddy
          NavbuddyName = { fg = palette.fujiWhite },
        }
      end,
    }

    -- set colorscheme in lua: https://github.com/neovim/neovim/issues/18201
    vim.o.background = 'dark'
    vim.cmd.colorscheme('kanagawa-wave')

    local palette = require 'kanagawa.colors'.setup().palette

    -- treesitter
    vim.api.nvim_set_hl(0, '@special', { link = 'Special' })
    vim.api.nvim_set_hl(0, '@namespace', { link = 'Constant' })
    vim.api.nvim_set_hl(0, '@parameter', { fg = palette.oldWhite })
    vim.api.nvim_set_hl(0, '@variable.builtin', { fg = palette.waveRed })

    -- semantic highlighting: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
    vim.api.nvim_set_hl(0, '@lsp.type.comment', { link = '@comment' })
    vim.api.nvim_set_hl(0, '@lsp.type.keyword', { link = '@keyword' })
    vim.api.nvim_set_hl(0, '@lsp.typemod.method.readonly.cpp', { link = '@function.method' })

  end
}
