return {
  'smiteshp/nvim-navbuddy',
  dependencies = {
    'smiteshp/nvim-navic',
    'muniftanjim/nui.nvim'
  },
  config = function()
    local navbuddy = require 'nvim-navbuddy'
    navbuddy.setup {
      window = {
        border = 'solid',
        size = '80%'
      },
      icons = {
        File = '󰈙 ',
        Package = ' ',
        Module = ' ',
        Namespace = ' ',
        Key = '󰌋 ',
        Operator = '󰆕 ',
        Null = ' ',
        Boolean = ' ',
        Number = "󰎠 ",
        String = ' ',
        Variable = '󰂡 ',
        Constant = '󰏿 ',
        Function = '󰊕 ',
        Array = ' ',
        Object = ' ',
        Enum = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Class = '󰠱 ',
        Interface = ' ',
        Field = ' ',
        Property = '󰜢 ',
        Constructor = '󰛄 ',
        Method = ' ',
        Event = ' ',
        TypeParameter = '󰅲 ',
      },
    }
  end,
}
