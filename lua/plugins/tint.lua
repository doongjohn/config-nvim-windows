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
        local ft = vim.bo.filetype
        if ft:find('Neogit') ~= nil then
          return true
        end
        if ft:find('Diffview') ~= nil then
          return true
        end

        local bt = vim.bo.buftype
        local is_floating = vim.api.nvim_win_get_config(winid).relative ~= ""
        return bt == 'terminal' or is_floating
      end
    }
  end
}
