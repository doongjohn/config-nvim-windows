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

    dap.adapters.lldb = {
      type = 'executable',
      command = vim.fn.exepath('lldb-vscode'),
      name = 'lldb'
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
        return vim.fn.getcwd() .. path:sub(2)
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = true,
    }

    dap.configurations.c = { lldb_config }
    dap.configurations.cpp = { lldb_config }
  end
}
