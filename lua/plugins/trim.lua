return {
  -- trim trailing whitespace
  'cappyzawa/trim.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    ft_blocklist = {
      'markdown',
    },
    patterns = {
      [[%s/\s\+$//e]],
      [[%s/\($\n\s*\)\+\%$//]],
      [[%s/\%^\n\+//]],
    },
  },
}
