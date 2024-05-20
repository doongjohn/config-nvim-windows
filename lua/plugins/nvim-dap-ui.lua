return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require 'dapui'.setup {}
  end
}
