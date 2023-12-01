return {
  -- search and replace
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = 'Spectre',
  opts = {
    live_update = true,
    line_sep_start = '[Search results]:',
    result_padding = '|  ',
    line_sep       = '[End]',
  },
}
