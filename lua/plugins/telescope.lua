return {
  -- telescope
  'nvim-telescope/telescope.nvim',
  event = 'BufEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'debugloop/telescope-undo.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
  },
  keys = {
    { '<space>', '<cmd>Telescope find_files<cr>' },
  },
  config = function()
    local telescope = require 'telescope'
    local telescope_actions = require 'telescope.actions'
    telescope.setup {
      defaults = {
        border = {},
        prompt_prefix = '   ',
        selection_caret = '  ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        path_display = { 'truncate' },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--hidden',
          '--trim',
          "-g '!build'",
        },
        mappings = {
          i = {
            ['<esc>'] = telescope_actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            'fd', '-tf', '-u',
            '--strip-cwd-prefix',

            -- exclude files
            '-E=*.a',
            '-E=*.o',
            '-E=*.so',
            '-E=*.obj',
            '-E=*.lib',
            '-E=*.dll',
            '-E=*.exe',

            -- exclude folders
            '-E=.objs',
            '-E=.deps',
            '-E=.cache',
            '-E=.git',
            '-E=.github',
            '-E=cache',
            '-E=vendor',
            '-E=dep',
            '-E=deps',
            '-E=lib',
            '-E=libs',
            '-E=out',
            '-E=build',
            '-E=target',
            '-E=dist',
            '-E=node_modules',
            '-E=zig-cache',
            '-E=zig-out',
          },
          hidden = true
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'ignore_case',
        },
      }
    }
    telescope.load_extension 'fzf'
    telescope.load_extension 'undo'
  end
}
