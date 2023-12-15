return {
  'nvim-island/hydra.nvim',
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
        { 'd', '<cmd>Bdelete<cr>', { desc = 'delete buffer' } },
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
        { 'r', function()
          local dap = require 'dap'

          local path_sep = '/'
          if vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
            path_sep = '\\'
          end

          local configs = {
            ['lldb_cpp'] = function()
              local path = vim.fn.input({
                prompt = 'executable path: ',
                default = '.' .. path_sep,
                completion = 'file',
              })
              local program = vim.fn.getcwd() .. path:sub(2)

              local args_str = vim.fn.input('args: ', '', 'file')
              local args = {}
              for substring in args_str:gmatch("%S+") do
                table.insert(args, substring)
              end

              return {
                name = 'lldb',
                type = 'lldb',
                request = 'launch',
                program = program,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = args,
                runInTerminal = true,
              }
            end
          }

          vim.ui.select({
            'lldb_cpp',
          }, {
            prompt = 'dap run',
          }, function(choice)
            dap.run(configs[choice]())
          end)
        end, { desc = 'run' } },
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
