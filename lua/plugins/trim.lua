return {
  -- trim trailing whitespace
  'cappyzawa/trim.nvim',
  event = 'BufEnter',
  config = function()
    require 'trim'.setup {
      ft_blocklist = {
        'markdown',
      },
      patterns = {
        [[%s/\s\+$//e]],
        [[%s/\($\n\s*\)\+\%$//]],
        [[%s/\%^\n\+//]],
      },
    }
  end
}
