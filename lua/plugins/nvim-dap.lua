return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'liadoz/nvim-dap-repl-highlights',
  },
  config = function()
    local dap = require 'dap'

    local path_sep = '/'
    if vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
      path_sep = '\\'
    end

    local program_args = {}

    dap.adapters.lldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.exepath('codelldb'),
        args = { '--port', '${port}' },
      },
    }

    local lldb_config = {
      name = 'lldb',
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
      cwd = '${workspaceFolder}',
      args = function()
        return program_args
      end,
    }

    -- this only works with gdb version > 14
    -- dap.adapters.gdb = {
    --   type = 'executable',
    --   command = vim.fn.exepath('gdb'),
    --   args = { '-i', 'dap' },
    -- }
    --
    -- local gdb_config = {
    --   name = 'gdb',
    --   type = 'gdb',
    --   request = 'launch',
    --   program = function()
    --     local path = vim.fn.input({
    --       prompt = 'executable path: ',
    --       default = '.' .. path_sep,
    --       completion = 'file',
    --     })
    --     return vim.fn.getcwd() .. path:sub(2)
    --   end,
    --   cwd = '${workspaceFolder}',
    --   args = function()
    --     local args_str = vim.fn.input('args: ', '', 'file')
    --     local args = {}
    --     for substring in args_str:gmatch("%S+") do
    --       table.insert(args, substring)
    --     end
    --     return args
    --   end,
    -- }

    dap.configurations.c = {
      lldb_config,
      -- gdb_config,
    }
    dap.configurations.cpp = {
      lldb_config,
      -- gdb_config,
    }
  end
}
