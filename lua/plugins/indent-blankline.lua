return {
  -- indent guide
  'lukas-reineke/indent-blankline.nvim',
  lazy = false,
  keys = {
    -- update indent-blankline on fold open and close
    { 'zo', 'zo:IndentBlanklineRefresh<cr>' },
    { 'zO', 'zO:IndentBlanklineRefresh<cr>' },
    { 'zc', 'zc:IndentBlanklineRefresh<cr>' },
    { 'zC', 'zC:IndentBlanklineRefresh<cr>' },
    { 'za', 'za:IndentBlanklineRefresh<cr>' },
    { 'zA', 'zA:IndentBlanklineRefresh<cr>' },
    { 'zv', 'zv:IndentBlanklineRefresh<cr>' },
    { 'zx', 'zx:IndentBlanklineRefresh<cr>' },
    { 'zX', 'zX:IndentBlanklineRefresh<cr>' },
    { 'zm', 'zm:IndentBlanklineRefresh<cr>' },
    { 'zM', 'zM:IndentBlanklineRefresh<cr>' },
    { 'zr', 'zr:IndentBlanklineRefresh<cr>' },
    { 'zR', 'zR:IndentBlanklineRefresh<cr>' },
    { 'zn', 'zn:IndentBlanklineRefresh<cr>' },
    { 'zN', 'zN:IndentBlanklineRefresh<cr>' },
    { 'zi', 'zi:IndentBlanklineRefresh<cr>' },
  },
  config = function()
    require 'indent_blankline'.setup {
      show_trailing_blankline_indent = false,
      max_indent_increase = 1,
      filetype_exclude = {
        'man',
        'help',
        'prompt',
        'terminal',
        'lspinfo',
        'lazy',
        'oil',
        'neo-tree',
        'neo-tree-popup',
        'toggleterm',
        'TelescopePrompt',
        'TelescopeResult',
        'Trouble',
      },
    }
  end
}
