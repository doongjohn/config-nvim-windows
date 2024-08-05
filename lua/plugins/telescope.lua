return {
  -- telescope
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim/issues/128#issuecomment-2235208849
      'nvim-telescope/telescope-fzf-native.nvim',
      build =
          'cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && ' ..
          'cmake --build build --config Release && ' ..
          'cmake --install build --prefix build',
    },
    'natecraddock/telescope-zf-native.nvim',
  },
  event = 'VeryLazy',
  keys = {
    { '<space>',    '<cmd>Telescope find_files<cr>' },
    { '<leader>ff', '<cmd>Telescope current_buffer_fuzzy_find<cr>' },
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
            'fd', '-tf', '-H',
            '--no-ignore-vcs',
            '--strip-cwd-prefix',

            -- exclude files
            '-E=*.a',
            '-E=*.o',
            '-E=*.so',
            '-E=*.obj',
            '-E=*.lib',
            '-E=*.dll',
            '-E=*.exe',
            '-E=*.pdb',

            -- exclude folders
            '-E=.git/',
            '-E=.github/',
            '-E=*cache/',
            '-E=obj/',
            '-E=.objs/',
            '-E=.deps/',
            '-E=lib/',
            '-E=libs/',
            '-E=bin/',
            '-E=out/',
            '-E=build/',
            '-E=target/',
            '-E=vendor/',
            '-E=dist/',
            '-E=node_modules/',
            '-E=zig-out/',
          },
          hidden = true
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_file_sorter = false,
          override_generic_sorter = true,
        },
        ['zf-native'] = {
          file = {
            enable = true,
            highlight_results = true,
            match_filename = true,
            initial_sort = nil,
            smart_case = true,
          },
          generic = {
            enable = false,
          },
        },
      }
    }
    telescope.load_extension 'fzf'
    telescope.load_extension 'zf-native'
  end
}
