return {
  -- toggleterm
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  opts = {
    shell = 'nu',
    shade_terminals = false,
  },
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      group = 'FtInit',
      pattern = { '*' },
      callback = function()
        if vim.api.nvim_win_get_config(0).relative ~= '' then
          return
        end
        if vim.bo.filetype == 'fzf' then
          return
        end

        local function toggleTerm()
          vim.cmd 'ToggleTerm direction=horizontal'
        end

        vim.keymap.set('n', '<c-k>', toggleTerm, { noremap = true, silent = true, buffer = true })
        vim.keymap.set('t', '<c-k>', toggleTerm, { noremap = true, silent = true, buffer = true })
      end
    })
  end
}
