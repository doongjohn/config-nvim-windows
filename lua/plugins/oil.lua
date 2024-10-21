return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  keys = {
    { '-', function() require 'oil'.open() end },
  },
  config = function()
    local oil = require 'oil'

    oil.setup {
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
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['<cr>'] = 'actions.select',
        ['<c-l>'] = {
          callback = function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'm', false)
          end,
          desc = 'ESC',
          mode = { 'v', 'i', 'o' },
        },
        ['<c-s>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<c-h>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
        ['<c-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
        ['<c-p>'] = 'actions.preview',
        ['<c-c>'] = 'actions.close',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
        ['<localleader>f'] = 'actions.refresh',
        ['<localleader>y'] = function()
          local dir = oil.get_current_dir()
          if not dir then return end

          local entry = oil.get_cursor_entry()
          if not entry then return end

          local filepath = dir .. entry.name
          local results = {
            filepath,
            vim.fn.fnamemodify(filepath, ':.'),
            vim.fn.fnamemodify(filepath, ':~'),
          }

          vim.ui.select({
            '1) Absolute path: ' .. results[1],
            '2) Relative path from CWD: ' .. results[2],
            '3) Relative path from HOME: ' .. results[3],
          }, { prompt = 'Choose a path to copy' }, function(choice)
            if not choice then return end

            local i = tonumber(choice:sub(1, 1))
            local result = results[i]
            vim.fn.setreg('"', result)
            vim.notify('Copied: ' .. result)
          end)
        end,
      },
    }
  end,
}
