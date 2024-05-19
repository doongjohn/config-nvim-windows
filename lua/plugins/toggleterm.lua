return {
  -- toggleterm
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  opts = {
    shell = 'nu',
    shade_terminals = false,
  },
  init = function()
    vim.api.nvim_create_autocmd('BufWinEnter', {
      group = 'doongjohn:BufWinEnter',
      pattern = { '*' },
      callback = function()
        if vim.api.nvim_win_get_config(0).relative ~= '' then
          return
        end
        if vim.bo.filetype == 'fzf' or vim.bo.filetype == 'Outline' then
          return
        end

        local function toggleTerm()
          vim.cmd 'ToggleTerm direction=horizontal'
        end

        vim.keymap.set('n', '<c-k>', toggleTerm, { buffer = true })
        vim.keymap.set('t', '<c-k>', toggleTerm, { buffer = true })
      end
    })
  end
}
