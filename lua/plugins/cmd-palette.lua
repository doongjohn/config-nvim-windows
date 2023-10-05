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
        label = '[file] switch cpp ↔ header',
        cmd = 'SwitchSourceAndHeader'
      },
      {
        label = '[file] switch cpp ↔ header (v-split)',
        cmd = 'vs | SwitchSourceAndHeader'
      },

      -- editor
      {
        label = '[editor] zen mode',
        cmd = 'ZenMode'
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
          vim.lsp.inlay_hint(0, nil)
        end
      },
      {
        label = '[lsp] references',
        cmd = 'Telescope lsp_references'
      },
      {
        label = '[lsp] workspace symbols',
        cmd = 'Telescope lsp_workspace_symbols'
      },
      {
        label = '[lsp] document symbols',
        cmd = 'Navbuddy'
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
            "terminal cmake-setup && " ..
            "cmake -S . -B build -G 'Ninja Multi-Config' && " ..
            "if test ! -e ./compile_commands.json; ln -s ./build/compile_commands.json ./compile_commands.json; end"
          )
          vim.cmd('startinsert')
        end
      },
      {
        label = '[cmake] generate',
        cmd = "!cmake -S . -B build -G \"Ninja Multi-Config\""
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
