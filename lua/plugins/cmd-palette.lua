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
        callback = require 'spectre'.open
      },
      {
        label = '[search] current file',
        callback = require 'spectre'.open_file_search
      },
      {
        label = '[search] ripgrep',
        callback = function()
          require 'rgflow'.open_blank('')
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
        label = '[lsp] type definitions',
        cmd = 'Glance type_definitions'
      },
      {
        label = '[lsp] implementations',
        cmd = 'Glance implementations'
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

      -- cmake
      {
        label = '[cmake] build',
        callback = function()
          local shell = vim.fs.basename(vim.o.shell):gsub("%..*$", "")

          local get_build_folders = {
            bash = function() return { '-c', [[fd -I -t=f 'CMakeCache\.txt']] } end,
            fish = function() return { '-c', [[fd -I -t=f 'CMakeCache\.txt']] } end,
            nu = function() return { '-c', [[fd -I -t=f 'CMakeCache\.txt']] } end,
            cmd = function() return { '/c', [[fd -I -t=f CMakeCache\.txt]] } end,
          }

          local get_targets = {
            bash = function(folder) return { '-c', [[fd -I -t=d '.+\.dir$' ]] .. folder } end,
            fish = function(folder) return { '-c', [[fd -I -t=d '.+\.dir$' ]] .. folder } end,
            nu = function(folder) return { '-c', [[fd -I -t=d '.+\.dir$' ]] .. folder } end,
            cmd = function(folder) return { '/c', [[fd -I -t=d .+\.dir$ ]] .. folder } end,
          }

          local function select_target_and_build(folder)
            local targets = {}
            local stdout = vim.uv.new_pipe()
            local stderr = vim.uv.new_pipe()

            local options = {
              args = get_targets[shell](folder),
              stdio = { nil, stdout, stderr },
            }

            ---@type uv_process_t|nil
            local handle = nil
            handle, _ = vim.uv.spawn(vim.o.shell, options, function(code, _)
              stdout:read_stop()
              stderr:read_stop()
              stdout:close()
              stderr:close()
              if handle then
                handle:close()
              end

              if code == 0 then
                vim.ui.select(targets, {
                  prompt = 'Select a target to build',
                }, function(choice)
                  vim.cmd('TermExec go_back=0 cmd="cmake --build ' .. folder .. ' --target ' .. choice .. '"')
                end)
              else
                print("exit code: " .. code)
              end
            end)

            vim.uv.read_start(stdout, function(_, data)
              if data then
                for line in data:gmatch("[^\r\n]+") do
                  table.insert(targets, vim.fs.basename(line:sub(1, -5 - 1)))
                end
              end
            end)

            vim.uv.read_start(stderr, function(_, data)
              if data then print(data) end
            end)
          end

          local function select_build_folder()
            local folders = {}
            local stdout = vim.uv.new_pipe()
            local stderr = vim.uv.new_pipe()

            local options = {
              args = get_build_folders[shell](),
              stdio = { nil, stdout, stderr },
            }

            ---@type uv_process_t|nil
            local handle = nil
            handle, _ = vim.uv.spawn(vim.o.shell, options, function(code, _)
              stdout:read_stop()
              stderr:read_stop()
              stdout:close()
              stderr:close()
              if handle then
                handle:close()
              end

              if code == 0 then
                vim.ui.select(folders, {
                  prompt = 'Select a build folder',
                }, function(choice)
                  select_target_and_build(choice)
                end)
              else
                print("exit code: " .. code)
              end
            end)

            vim.uv.read_start(stdout, function(_, data)
              if data then
                for line in data:gmatch("[^\r\n]+") do
                  table.insert(folders, vim.fs.dirname(line))
                end
              end
            end)

            vim.uv.read_start(stderr, function(_, data)
              if data then print(data) end
            end)
          end

          select_build_folder()
        end
      },
    }

    vim.keymap.set('n', '<c-p>', function()
      require 'cmd-palette'.setup(opts)
      vim.cmd('CmdPalette')
    end)
  end
}
