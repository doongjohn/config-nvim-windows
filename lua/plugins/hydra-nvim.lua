return {
  'anuvyklack/hydra.nvim',
  lazy = false,
  config = function()
    local hydra = require 'hydra'
    hydra({
      name = 'Side scroll',
      mode = 'n',
      body = 'z',
      heads = {
        { 'h', 'zh' },
        { 'l', 'zl', { desc = '' } },
        { 'H', 'zH' },
        { 'L', 'zL', { desc = 'half screen ' } },
      }
    })
    hydra({
      name = 'Window',
      mode = 'n',
      body = '<c-w>',
      heads = {
        { '<c-h>', '<c-w>h' },
        { '<c-j>', '<c-w>j' },
        { '<c-k>', '<c-w>k' },
        { '<c-l>', '<c-w>l', { desc = 'navigate' } },
        { '-', '<c-w><' },
        { '=', '<c-w>>', { desc = 'resize 󰤼' } },
        { '_', '<c-w>-' },
        { '+', '<c-w>+', { desc = 'resize 󰤻' } },
        { 'e', '<c-w>=', { desc = 'equal size' } },
        { 'd', '<cmd>Bdelete<cr>', { desc = 'delete buffer' } },
        { 'c', '<c-w>q', { desc = 'close window' } },
        { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
      }
    })
  end
}
