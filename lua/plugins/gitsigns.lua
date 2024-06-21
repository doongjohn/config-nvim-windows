return {
  -- git sign
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'Gitsigns' },
  opts = {
    current_line_blame = false,
  },
}
