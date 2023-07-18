return {
  'ojroques/nvim-bufdel',
  keys = {
    { '<leader>d', '<cmd>BufDel<cr>' },
  },
  opts = {
    next = 'tabs', -- or 'cycle, 'alternate'
    quit = false, -- quit Neovim when last buffer is closed
  },
}
