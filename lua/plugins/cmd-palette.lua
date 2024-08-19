return {
  'koenverburg/cmd-palette.nvim',
  dependencies = {
    'stevearc/dressing.nvim',
  },
  lazy = false,
  config = function()
    local opts = {
      -- editor
      {
        label = '[editor] plugins',
        cmd = 'Lazy home',
      },
      {
        label = '[editor] sessions',
        cmd = 'SessionManager available_commands',
      },
      {
        label = '[editor] messages',
        callback = function()
          vim.cmd('split')
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_call(buf, function()
            vim.cmd([[put =execute('messages')]])
            vim.cmd([[%s/\%^\n\+//]])
          end)
          vim.api.nvim_win_set_buf(0, buf)
          vim.cmd([[norm GG]])
        end,
      },
      {
        label = '[editor] registers',
        cmd = 'Telescope registers',
      },
      {
        label = '[editor] command history',
        cmd = 'Telescope command_history',
      },
      {
        label = '[editor] tab new',
        cmd = 'tabnew',
      },
      {
        label = '[editor] tab close',
        cmd = 'tabclose',
      },

      -- file
      {
        label = '[file] recent',
        cmd = 'Telescope oldfiles',
      },
      {
        label = '[file] yank all',
        cmd = '%y',
      },
      {
        label = '[file] cd → nvim config',
        cmd = 'cd ' .. vim.fn.stdpath('config'),
      },

      -- search
      {
        label = '[search] all files',
        callback = function()
          require 'grug-far'.grug_far()
        end,
      },
      {
        label = '[search] current file',
        callback = function()
          require 'grug-far'.grug_far({ prefills = { flags = vim.fn.expand('%') } })
        end,
      },
      {
        label = '[search] document symbols',
        cmd = 'Telescope lsp_document_symbols',
      },

      -- git
      {
        label = '[git] neogit open',
        cmd = 'Neogit',
      },
      {
        label = '[git] diffview open',
        cmd = 'DiffviewOpen',
      },
      {
        label = '[git] diffview file history',
        cmd = 'DiffviewFileHistory %',
      },

      -- lsp
      {
        label = '[lsp] format',
        callback = function()
          HighlighterSkip = true
          vim.lsp.buf.format()
          vim.cmd 'up'
          HighlighterSkip = false
        end,
      },
      {
        label = '[lsp] inlay hint toggle',
        callback = function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        end,
      },
      {
        label = '[lsp] references',
        cmd = 'Glance references',
      },
      {
        label = '[lsp] outline',
        cmd = 'Outline',
      },
      {
        label = '[lsp] c, cpp switch source ↔ header',
        callback = function()
          for _, v in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            if v.config.name == 'clangd' then
              vim.cmd('ClangdSwitchSourceHeader')
              break
            end
          end
          print('[lsp] c, cpp switch source ↔ header: clangd not active')
        end,
      },
      {
        label = '[lsp] c, cpp switch source ↔ header (v-split)',
        callback = function()
          for _, v in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            if v.config.name == 'clangd' then
              vim.cmd('vs | ClangdSwitchSourceHeader')
              break
            end
          end
          print('[lsp] c, cpp switch source ↔ header (v-split): clangd not active')
        end,
      },

      -- dap
      {
        label = '[dap] toggle ui',
        callback = function()
          require 'dapui'.toggle({ reset = true })
        end,
      },
      {
        label = '[dap] focus frame',
        callback = function()
          require 'dap'.focus_frame()
        end,
      },
    }

    vim.keymap.set('n', '<c-p>', function()
      local palette = require 'cmd-palette'
      palette.setup(opts)
      palette.show()
    end)
  end
}
