return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '-', function() require('oil').open() end },
  },
  opts = {
    -- delete_to_trash = true, -- windows not supported
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        return vim.startswith(name, '..')
      end,
    },
  },
}
