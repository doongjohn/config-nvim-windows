return {
  -- translation
  'potamides/pantran.nvim',
  keys = {
    { '<leader>r', '<cmd>Pantran<cr>i' },
    { '<leader>r', 'y<cmd>Pantran source=auto target=ko<cr>p', mode = 'v' },
  },
  config = function()
    require 'pantran'.setup {
      default_engine = "google",
    }
  end
}
