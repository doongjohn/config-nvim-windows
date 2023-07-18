return {
  -- buffer switcher / closer
  'toppair/reach.nvim',
  keys = {
    {
      '<leader><space>', function()
        require 'reach'.buffers({ show_current = true })
      end
    }
  },
  opts = {
    notifications = true
  },
}
