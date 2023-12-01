return {
  -- dim inactive window
  'levouh/tint.nvim',
  lazy = false,
  config = function()
    require 'tint'.setup {
      tint = -40,
      saturation = 0.8,
      highlight_ignore_patterns = { 'WinSeparator', 'Status.*' },
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_get_current_buf()
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufid })
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

        -- Do not tint `terminal` or floating windows, tint everything else
        return buftype == 'terminal' or floating
      end
    }
  end
}
