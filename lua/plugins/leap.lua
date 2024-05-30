return {
  -- fast cursor movement
  'ggandor/leap.nvim',
  event = 'BufEnter',
  config = function()
    local leap = require 'leap'
    leap.setup {
      highlight_unlabeled_phase_one_targets = true,
    }

    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    vim.api.nvim_set_hl(0, 'LeapMatch', {
      fg = 'white',
      bold = true,
      nocombine = true,
    })

    local function leapSearch()
      leap.leap { target_windows = require 'leap.user'.get_focusable_windows() }
    end

    vim.keymap.set('n', 'm', leapSearch)
    vim.keymap.set('v', 'm', leapSearch)
    vim.keymap.set('o', 'm', leapSearch)
  end
}
