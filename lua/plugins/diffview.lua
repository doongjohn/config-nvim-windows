return {
  'sindrets/diffview.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  cmd = {
    'DiffviewClose',
    'DiffviewFileHistory',
    'DiffviewFocusFiles',
    'DiffviewLog',
    'DiffviewOpen',
    'DiffviewRefresh',
    'DiffviewToggleFiles',
  },
  opts = {
    hooks = {
      diff_buf_win_enter = function(bufnr)
        vim.keymap.set('n', 'q', '<cmd>DiffviewClose<cr>', { buffer = bufnr })
      end,
      view_opened = function(view)
        if view.class:name() == 'FileHistoryView' then
          local buffers = vim.fn.tabpagebuflist()
          for _, bufnr in ipairs(buffers) do
            if #vim.api.nvim_get_option_value('buftype', { buf = bufnr }) ~= 0 then
              vim.keymap.set('n', 'q', '<cmd>DiffviewClose<cr>', { buffer = bufnr })
            end
          end
        end
      end,
    }
  },
}
