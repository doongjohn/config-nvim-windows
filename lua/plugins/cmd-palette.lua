return {
  'koenverburg/cmd-palette.nvim',
  dependencies = {
    'stevearc/dressing.nvim',
  },
  keys = {
    { '<c-p>', '<cmd>CmdPalette<cr>' },
  },
  config = function()
    require 'cmd-palette'.setup {
      -- plugin
      {
        label = '[plugin] update',
        cmd = 'Lazy update'
      },
      {
        label = '[plugin] clean',
        cmd = 'Lazy clean'
      },

      -- file
      {
        label = '[file] recent',
        cmd = 'Telescope oldfiles'
      },
      {
        label = '[file] cd → nvim config',
        cmd = 'cd ~/AppData/Local/nvim/'
      },
      {
        label = '[file] switch source ↔ header',
        cmd = 'ClangdSwitchSourceHeader'
      },
      {
        label = '[file] switch source ↔ header (v-split)',
        cmd = 'vs | ClangdSwitchSourceHeader'
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
        label = '[editor] zen mode',
        cmd = 'ZenMode'
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
          local pattern = vim.fn.input('pattern: ')
          vim.cmd('vimgrep /' .. pattern .. '/ ./** | copen')
        end
      },
      {
        label = '[search] current file',
        callback = function()
          local pattern = vim.fn.input('pattern: ')
          vim.cmd('vimgrep /' .. pattern .. '/ % | copen')
        end
      },
      {
        label = '[search] ripgrep',
        callback = function()
          require('rgflow').open_blank('')
        end
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
          vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.get({ bufnr = 0 })[1])
        end
      },
      {
        label = '[lsp] references',
        cmd = 'Telescope lsp_references'
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
        label = '[lsp] code action',
        callback = vim.lsp.buf.code_action
      },

      -- cmake
      {
        label = '[cmake] setup',
        callback = function()
          vim.cmd(
            'terminal cmake-setup && ' ..
            'cmake -S . -B build -G "Ninja Multi-Config"'
          )
          vim.cmd('startinsert')
        end
      },
      {
        label = '[cmake] generate',
        cmd = '!cmake -S . -B build -G "Ninja Multi-Config"'
      },
      {
        label = '[cmake] build debug',
        cmd = 'TermExec cmd="cmake --build build -v --config Debug" go_back=0',
      },
      {
        label = '[cmake] build release',
        cmd = 'TermExec cmd="cmake --build build -v --config Release" go_back=0',
      },
    }
  end
}
