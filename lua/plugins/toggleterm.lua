require 'utils'
return {
  -- toggleterm
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  init = function()
    local function toggleTerm()
      if vim.api.nvim_win_get_config(0).relative ~= '' then
        return
      end
      if vim.bo.filetype == 'fzf' then
        return
      end
      vim.cmd 'ToggleTerm direction=horizontal'
    end

    keymap_s('n', '<c-k>', toggleTerm)
    keymap_s('t', '<c-k>', toggleTerm)
  end,
  config = function()
    local toggleterm = require 'toggleterm'
    toggleterm.setup {
      shade_terminals = false,
      shell = 'nu',
    }
  end
}
