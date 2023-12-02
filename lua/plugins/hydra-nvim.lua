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
        { 'h', '<c-w>h' },
        { 'j', '<c-w>j' },
        { 'k', '<c-w>k' },
        { 'l', '<c-w>l', { desc = 'navigate 󱣱' } },
        { '-', '<c-w><' },
        { '=', '<c-w>>', { desc = 'resize 󰤼' } },
        { '_', '<c-w>-' },
        { '+', '<c-w>+', { desc = 'resize 󰤻' } },
        { 'e', '<c-w>=', { desc = 'equal size' } },
        { 'q', '<c-w>q', { desc = 'close window' } },
      }
    })
  end
}
