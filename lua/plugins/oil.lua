return {
  'stevearc/oil.nvim',
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
      is_always_hidden = function(name, bufnr)
        return vim.startswith(name, '..')
      end,
    },
  },
}
