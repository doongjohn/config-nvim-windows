return {
  -- toggleterm
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  opts = {
    shell = 'nu',
    shade_terminals = false,
  },
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

    vim.keymap.set('n', '<c-k>', toggleTerm, { noremap = true, silent = true })
    vim.keymap.set('t', '<c-k>', function() vim.cmd 'ToggleTermToggleAll' end, { noremap = true, silent = true })
  end,
}
