return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '-', function() require("oil").open() end },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
}
