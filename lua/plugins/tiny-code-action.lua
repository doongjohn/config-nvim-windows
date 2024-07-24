return {
  -- code action menu with preview
  'rachartier/tiny-code-action.nvim',
  event = 'LspAttach',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },
  },
  keys = {
    { '<leader><leader>', function() require 'tiny-code-action'.code_action() end },
  },
  opts = {},
}
