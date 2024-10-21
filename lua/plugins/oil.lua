return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  keys = {
    { '-', function() require 'oil'.open() end },
  },
  opts = {
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        return vim.startswith(name, '..')
      end,
    },
    use_default_keymaps = false,
    keymaps = {
      ['g?'] = 'actions.show_help',
      ['<cr>'] = 'actions.select',
      ['<c-s>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
      ['<c-h>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
      ['<c-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
      ['<c-p>'] = 'actions.preview',
      ['<c-c>'] = 'actions.close',
      ['<localleader>f'] = 'actions.refresh',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['g.'] = 'actions.toggle_hidden',
      ['g\\'] = 'actions.toggle_trash',
      ['<localleader>y'] = 'actions.yank_entry',
      ['<c-l>'] = {
        callback = function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'm', false)
        end,
        desc = 'ESC',
        mode = { 'v', 'i', 'o' },
      },
    },
  }
}
