require 'utils'
return {
  -- fast cursor movement
  'ggandor/leap.nvim',
  event = 'BufEnter',
  config = function()
    local leap = require 'leap'
    leap.setup {}
    leap.opts.highlight_unlabeled_phase_one_targets = true
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    vim.api.nvim_set_hl(0, 'LeapMatch', {
      fg = 'white',
      bold = true,
      nocombine = true,
    })

    local function is_floating_window()
      local win_config = vim.api.nvim_win_get_config(0)
      return win_config.relative ~= ''
    end

    local function get_target_windows()
      if is_floating_window() then
        return { vim.fn.win_getid() }
      else
        return vim.tbl_filter(
          function (win) return vim.api.nvim_win_get_config(win).focusable end,
          vim.api.nvim_tabpage_list_wins(0)
        )
      end
    end

    local function leapSearch()
      leap.leap { target_windows = get_target_windows() }
    end

    keymap_s('n', 'm', leapSearch)
    keymap_s('v', 'm', leapSearch)
    keymap_s('o', 'm', leapSearch)
  end
}
