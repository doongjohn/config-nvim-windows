return {
  'ojroques/nvim-bufdel',
  keys = {
    { '<leader>d', '<cmd>BufDel<cr>' },
  },
  config = function()
    require('bufdel').setup {
      next = 'tabs',  -- or 'cycle, 'alternate'
      quit = false,    -- quit Neovim when last buffer is closed
    }
  end
}
