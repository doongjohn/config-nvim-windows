return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require 'dapui'.setup {}
  end
}
