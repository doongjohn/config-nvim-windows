return {
  -- code snippet
  'dcampos/nvim-snippy',
  config = function()
    require 'snippy'.setup {
      mappings = {
        is = {
          ['<tab>'] = 'expand_or_advance',
          ['<s-tab>'] = 'previous',
        },
      },
    }
  end
}
