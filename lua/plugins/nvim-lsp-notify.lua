return {
  -- lsp progress
  'mrded/nvim-lsp-notify',
  config = function()
    require 'lsp-notify'.setup {
      notify = require 'notify',
    }
  end,
}
