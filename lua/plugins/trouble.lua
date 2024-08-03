return {
  -- diagnostic list
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>t', '<cmd>Trouble diagnostics focus<cr>' },
  },
  opts = {},
}
