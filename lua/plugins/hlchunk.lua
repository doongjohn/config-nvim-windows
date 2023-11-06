return {
  'shellRaining/hlchunk.nvim',
  event = { 'UIEnter' },
  config = function()
    local excludes = require 'hlchunk.utils.filetype'.exclude_filetypes
    excludes.oil_preview = true

    local opts = {
      chunk = {
        enable = false,
        exclude_filetypes = excludes
      },
      indent = {
        style = {
          '#3b3b4d',
        },
      },
      line_num = {
        enable = false,
      },
      blank = {
        enable = false,
      },
    }

    ---@diagnostic disable-next-line: missing-fields
    require 'hlchunk'.setup(opts)
  end
}
