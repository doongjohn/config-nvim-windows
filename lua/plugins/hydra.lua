return {
  'nvimtools/hydra.nvim',
  event = 'VeryLazy',
  config = function()
    local hydra = require 'hydra'

    hydra({
      name = 'side scroll',
      mode = 'n',
      body = 'z',
      heads = {
        { 'h', 'zh' },
        { 'l', 'zl', { desc = '' } },
        { 'H', 'zH' },
        { 'L', 'zL', { desc = 'half screen ' } },
      }
    })

    hydra({
      name = 'window',
      mode = 'n',
      body = '<c-w>',
      heads = {
        { 'p', function()
          require 'nvim-window'.pick()
        end, { desc = 'pick' } },
        { '-', '<c-w><' },
        { '=', '<c-w>>', { desc = '󰤼 resize' } },
        { '_', '<c-w>-' },
        { '+', '<c-w>+', { desc = '󰤻 resize' } },
        { 'e', '<c-w>=', { desc = 'equal size' } },
        { 'b', '<cmd>Bdelete<cr>', { desc = 'delete buffer' } },
        { 'q', '<c-w>q', { desc = 'quit window' } },
      }
    })

    hydra({
      name = 'git',
      config = {
        color = 'pink',
        timeout = false,
        invoke_on_body = true,
        hint = {
          type = 'window',
          offset = -1,
        },
      },
      mode = 'n',
      body = '<leader>g',
      heads = {
        { 'n', '<cmd>Gitsigns next_hunk<cr>',    { desc = 'next hunk' } },
        { 'N', '<cmd>Gitsigns prev_hunk<cr>',    { desc = 'prev hunk' } },
        { 'p', '<cmd>Gitsigns preview_hunk<cr>', { desc = 'preview hunk' } },
        { 'r', '<cmd>Gitsigns reset_hunk<cr>',   { desc = 'reset hunk' } },
        { 'q', nil,                              { desc = 'exit', exit = true, nowait = true } },
      }
    })

    hydra({
      name = 'dap',
      config = {
        color = 'pink',
        invoke_on_body = true,
        hint = {
          type = 'window',
          offset = -1,
        },
      },
      mode = 'n',
      body = '<leader>d',
      heads = {
        { '<c-m>', function()
          require 'dapui'.toggle({ reset = true })
        end, { desc = 'ui' } },
        { '<c-b>', require 'dap'.toggle_breakpoint, { desc = 'toggle bp' } },
        { '<c-x>', require 'dap'.clear_breakpoints, { desc = 'clear bp' } },
        { 'c',     require 'dap'.continue,          { desc = 'continue' } },
        { 'n',     require 'dap'.step_over,         { desc = 'step-over' } },
        { 's',     require 'dap'.step_into,         { desc = 'step-into' } },
        { 'o',     require 'dap'.step_over,         { desc = 'step-out' } },
        { 'i',     require 'dap.ui.widgets'.hover,  { desc = 'inspect' } },
        { 't',     require 'dap'.terminate,         { desc = 'terminate' } },
        { 'q',     nil,                             { desc = 'exit', exit = true, nowait = true } },
      }
    })
  end
}
