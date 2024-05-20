return {
  'nvimtools/hydra.nvim',
  lazy = false,
  config = function()
    local hydra = require 'hydra'

    hydra({
      name = 'Side scroll',
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
      name = 'Window',
      mode = 'n',
      body = '<c-w>',
      heads = {
        { 'p', function()
          require 'nvim-window'.pick()
        end, { desc = 'pick' }},
        { '-', '<c-w><' },
        { '=', '<c-w>>', { desc = 'resize 󰤼' } },
        { '_', '<c-w>-' },
        { '+', '<c-w>+', { desc = 'resize 󰤻' } },
        { 'e', '<c-w>=', { desc = 'equal size' } },
        { 'b', '<cmd>Bdelete<cr>', { desc = 'delete buffer' } },
        { 'c', '<c-w>q', { desc = 'close window' } },
        { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
      }
    })

    hydra({
      name = 'dap',
      config = {
        color = 'pink',
        invoke_on_body = true,
        hint = {
          type = 'window',
        },
      },
      mode = 'n',
      body = '<leader>d',
      heads = {
        { '<c-m>', function()
          require 'dapui'.toggle({ reset = true })
        end , { desc = 'toggle ui' } },
        { '<c-b>', require 'dap'.toggle_breakpoint, { desc = 'toggle breakpoint' } },
        { 'c', require 'dap'.continue, { desc = 'continue' } },
        { 'n', require 'dap'.step_over, { desc = 'step-over' } },
        { 's', require 'dap'.step_into, { desc = 'step-into' } },
        { 'o', require 'dap'.step_over, { desc = 'step-out' } },
        { 'i', require 'dap.ui.widgets'.hover, { desc = 'inspect' } },
        { 't', require 'dap'.terminate, { desc = 'terminate' } },
        { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
      }
    })
  end
}
