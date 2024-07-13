return {
  'koenverburg/cmd-palette.nvim',
  lazy = false,
  dependencies = {
    'stevearc/dressing.nvim',
  },
  config = function()
    local opts = {
      -- plugin
      {
        label = '[plugin] lazy',
        callback = function()
          require 'cmd-palette'.setup({
            {
              label = '[lazy] sync',
              cmd = 'Lazy sync'
            },
            {
              label = '[lazy] update',
              cmd = 'Lazy update'
            },
            {
              label = '[lazy] clean',
              cmd = 'Lazy clean'
            },
            {
              label = '[lazy] profile',
              cmd = 'Lazy profile'
            },
          })
          vim.cmd('CmdPalette')
        end
      },

      -- file
      {
        label = '[file] recent',
        cmd = 'Telescope oldfiles'
      },
      {
        label = '[file] yank all',
        cmd = '%y'
      },
      {
        label = '[file] cd → nvim config',
        cmd = 'cd ~/AppData/Local/nvim/'
      },

      -- editor
      {
        label = '[editor] messages',
        callback = function()
          vim.cmd('split')
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_call(buf, function()
            vim.cmd("put =execute('messages')")
          end)
          vim.api.nvim_win_set_buf(0, buf)
          vim.cmd('exe "norm G"')
        end
      },
      {
        label = '[editor] registers',
        cmd = 'Telescope registers'
      },
      {
        label = '[editor] command history',
        cmd = 'Telescope command_history'
      },
      {
        label = '[editor] undo history',
        cmd = 'Telescope undo'
      },
      {
        label = '[editor] tab new',
        cmd = 'tabnew'
      },
      {
        label = '[editor] tab close',
        cmd = 'tabclose'
      },

      -- search
      {
        label = '[search] all files',
        callback = function()
          require 'grug-far'.grug_far()
        end
      },
      {
        label = '[search] current file',
        callback = function()
          require 'grug-far'.grug_far({ prefills = { flags = vim.fn.expand("%") } })
        end
      },
      {
        label = '[search] document symbols',
        cmd = 'Telescope lsp_document_symbols'
      },

      -- git
      {
        label = '[git] neogit open',
        cmd = 'Neogit'
      },
      {
        label = '[git] diffview open',
        cmd = 'DiffviewOpen'
      },
      {
        label = '[git] diffview file history',
        cmd = 'DiffviewFileHistory %'
      },

      -- lsp
      {
        label = '[lsp] format',
        callback = function()
          vim.lsp.buf.format()
          vim.cmd 'up'
        end
      },
      {
        label = '[lsp] inlay hint toggle',
        callback = function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        end
      },
      {
        label = '[lsp] references',
        cmd = 'Glance references'
      },
      {
        label = '[lsp] outline',
        cmd = 'Outline'
      },
      {
        label = '[lsp] line diagnostics',
        callback = function()
          vim.diagnostic.open_float({ scope = 'line' })
        end
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
        label = '[dap] clear breakpoints',
        callback = function()
          require 'dap'.clear_breakpoints()
        end
      },
      {
        label = '[dap] focus frame',
        callback = function()
          require 'dap'.focus_frame()
        end
      },
    }

    vim.keymap.set('n', '<c-p>', function()
      require 'cmd-palette'.setup(opts)
      vim.cmd('CmdPalette')
    end)
  end
}
