return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'liadoz/nvim-dap-repl-highlights',
  },
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

    local lldb_config = {
      name = 'Debug C/C++ (lldb)',
      type = 'lldb',
      request = 'launch',
      program = function()
        local path = vim.fn.input({
          prompt = 'executable path: ',
          default = '.' .. path_sep,
          completion = 'file',
        })
        path = vim.fn.getcwd() .. path:sub(2)

        program_args = {}
        local args_str = vim.fn.input('args: ', '', 'file')
        for substring in args_str:gmatch("%S+") do
          table.insert(program_args, substring)
        end

        return (path and path ~= "") and path or dap.ABORT
      end,
      args = function()
        return program_args
      end,
      cwd = '${workspaceFolder}',
    }

    -- this only works with gdb version > 14
    -- dap.adapters.gdb = {
    --   type = 'executable',
    --   command = vim.fn.exepath('gdb'),
    --   args = { '-i', 'dap' },
    -- }
    --
    -- local gdb_config = {
    --   name = 'Debug C/C++ (gdb)',
    --   type = 'gdb',
    --   request = 'launch',
    --   program = function()
    --     local path = vim.fn.input({
    --       prompt = 'executable path: ',
    --       default = '.' .. path_sep,
    --       completion = 'file',
    --     })
    --     path = vim.fn.getcwd() .. path:sub(2)
    --
    --     program_args = {}
    --     local args_str = vim.fn.input('args: ', '', 'file')
    --     for substring in args_str:gmatch("%S+") do
    --       table.insert(program_args, substring)
    --     end
    --
    --     return (path and path ~= "") and path or dap.ABORT
    --   end,
    --   args = function()
    --     return program_args
    --   end,
    --   cwd = '${workspaceFolder}',
    -- }

    dap.configurations.c = { lldb_config }
    dap.configurations.cpp = { lldb_config }
  end
}
