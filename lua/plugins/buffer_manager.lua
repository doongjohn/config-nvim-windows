return {
  -- buffer manager
  'j-morano/buffer_manager.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>]', function()
        require 'buffer_manager.ui'.toggle_quick_menu()
      end
    }
  },
  opts = {
    borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    show_indicators = 'before',
  },
}
