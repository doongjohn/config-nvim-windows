return {
  -- window picker
  'yorickpeterse/nvim-window',
  event = 'BufEnter',
  keys = {
    { '<leader>w', function() require 'nvim-window'.pick() end },
  },
  opts = {
    normal_hl = 'DiagnosticLineNrInfo',
    hint_hl = 'Bold',
    border = 'none'
  },
}
