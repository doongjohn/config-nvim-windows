return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'

    local is_windows = vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1
    local path_sep = is_windows and '\\' or '/'

    local program_args = {}

    dap.adapters.lldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.exepath('lldb-dap'),
        args = { '--port', '${port}' },
        detached = is_windows and false or true,
      },
    }
    local config_lldb = {
      name = 'lldb',
      type = 'lldb',
      request = 'launch',
      program = function()
        local program_path = vim.fn.input({
          prompt = 'executable path: ',
          default = '.' .. path_sep,
          completion = 'file',
        })
        program_path = vim.fn.getcwd() .. program_path:sub(2)

        program_args = {}
        local args_str = vim.fn.input('args: ', '', 'file')
        for substring in args_str:gmatch('%S+') do
          table.insert(program_args, substring)
        end

        return program_path
      end,
      args = function()
        return program_args
      end,
      cwd = '${workspaceFolder}',
    }

    -- this only works with gdb version > 14
    dap.adapters.gdb = {
      type = 'executable',
      command = vim.fn.exepath('gdb'),
      args = { '-i', 'dap' },
    }
    local config_gdb = {
      name = 'gdb',
      type = 'gdb',
      request = 'launch',
      program = function()
        local program_path = vim.fn.input({
          prompt = 'executable path: ',
          default = '.' .. path_sep,
          completion = 'file',
        })
        program_path = vim.fn.getcwd() .. program_path:sub(2)

        program_args = {}
        local args_str = vim.fn.input('args: ', '', 'file')
        for substring in args_str:gmatch('%S+') do
          table.insert(program_args, substring)
        end

        return program_path
      end,
      args = function()
        return program_args
      end,
      cwd = '${workspaceFolder}',
    }

    dap.configurations.c = { config_lldb, config_gdb }
    dap.configurations.cpp = { config_lldb, config_gdb }
  end
}
