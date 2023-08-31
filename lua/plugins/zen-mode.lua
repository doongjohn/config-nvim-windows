return {
  -- comment toggle
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
  opts = {
    window = {
      width = 130,
      height = 1,
    },
    plugins = {
      wezterm = {
        enabled = true,
        -- can be either an absolute font size or the number of incremental steps
        font = "+4", -- (10% increase per step)
      },
    },
    on_open = function()
      vim.cmd('doautocmd FileType')
    end
  },
}
