return {
  -- statusline
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    require 'lualine'.setup {
      options = {
        globalstatus = true,
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          -- filetype
        },
      },
    }
  end
}
