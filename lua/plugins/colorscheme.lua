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
          -- navic
          NavicIconsFile = { fg = palette.fujiWhite },
          NavicIconsModule = { link = '@namespace' },
          NavicIconsNamespace = { link = '@namespace' },
          NavicIconsPackage = { link = '@namespace' },
          NavicIconsClass = { link = '@lsp.type.class' },
          NavicIconsMethod = { link = '@lsp.type.method' },
          NavicIconsProperty = { link = '@lsp.type.property' },
          NavicIconsField = { link = '@field' },
          NavicIconsConstructor = { link = '@constructor' },
          NavicIconsEnum = { link = '@lsp.type.enum' },
          NavicIconsInterface = { link = '@lsp.type.interface' },
          NavicIconsFunction = { link = '@lsp.type.function' },
          NavicIconsVariable = { link = '@lsp.type.variable' },
          NavicIconsConstant = { link = '@constant' },
          NavicIconsString = { link = '@string' },
          NavicIconsNumber = { link = '@number' },
          NavicIconsBoolean = { link = '@boolean' },
          NavicIconsArray = { link = '@lsp.type.enumMember' },
          NavicIconsObject = { link = '@lsp.type.enumMember' },
          NavicIconsKey = { link = '@keyword' },
          NavicIconsNull = { link = '@constant.builtin' },
          NavicIconsEnumMember = { link = '@lsp.type.enumMember' },
          NavicIconsStruct = { link = '@lsp.type.type' },
          NavicIconsEvent = { link = '@lsp.type.function' },
          NavicIconsOperator = { link = '@operator' },
          NavicIconsTypeParameter = { link = '@lsp.type.enumMember' },
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
    vim.api.nvim_set_hl(0, '@namespace', { link = 'Constant' })
    vim.api.nvim_set_hl(0, '@parameter', { fg = palette.oldWhite })
    vim.api.nvim_set_hl(0, '@variable.builtin', { fg = palette.waveRed })

    -- semantic highlighting: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
    vim.api.nvim_set_hl(0, '@lsp.type.comment', { link = '@comment' })
    vim.api.nvim_set_hl(0, '@lsp.type.keyword', { link = '@keyword' })

  end
}
