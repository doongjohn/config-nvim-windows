return {
  -- treesitter
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'liadoz/nvim-dap-repl-highlights',
    'nushell/tree-sitter-nu',
  },
  config = function()
    require 'nvim-dap-repl-highlights'.setup()

    ---@diagnostic disable-next-line: missing-fields
    require 'nvim-treesitter.configs'.setup {
      sync_install = false,
      ensure_installed = {
        -- shell
        'bash', 'fish', 'nu',
        -- build script
        'make', 'cmake', 'ninja',
        -- misc
        'regex', 'dap_repl',
        -- compiled lanuages
        'c', 'cpp', 'c_sharp',
        'rust', 'zig', 'odin',
        'go', 'gomod', 'gosum', 'gowork',
        'nim', 'nim_format_string',
        'ocaml', 'commonlisp', 'racket',
        -- scripting lanuages
        'python', 'ruby', 'julia',
        'lua', 'fennel', 'vim',
        -- shader
        'wgsl', 'glsl', 'hlsl',
        -- web dev
        'html', 'css', 'scss',
        'javascript', 'jsdoc',
        'typescript', 'tsx',
        'astro', 'svelte', 'vue',
        -- markup
        'markdown', 'latex', 'rst',
        -- data
        'json', 'jsonc',
        'ini', 'toml', 'yaml',
        -- git
        'diff',
        'gitcommit',
        'git_rebase',
        'git_config',
        'gitignore',
        'gitattributes',
      },
      ignore_install = {
        -- 'somelanguage'
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = {
          -- 'somelanguage'
          'crystal',
        },
      },
      indent = {
        enable = true,
        disable = {
          'cpp',
          'zig',
          'odin',
          'lua',
          'html',
          'javascript',
        },
      }
    }
  end
}
