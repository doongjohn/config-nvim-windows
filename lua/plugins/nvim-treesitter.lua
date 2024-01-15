return {
  -- treesitter
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require 'nvim-treesitter.configs'.setup {
      sync_install = false,
      ensure_installed = {
        'c', 'cpp',
        'rust',
        'zig',
        'odin',
        'go', 'gomod', 'gosum', 'gowork',
        'c_sharp',
        'ocaml',
        'commonlisp',
        'racket',
        'regex',
        -- build
        'make', 'cmake', 'ninja',
        -- shader
        'wgsl', 'glsl', 'hlsl',
        -- web dev
        'html', 'css', 'scss',
        'javascript', 'jsdoc',
        'typescript', 'tsx',
        'astro', 'svelte', 'vue',
        -- scripting
        'bash', 'fish',
        'python', 'julia', 'ruby',
        'lua', 'fennel', 'vim',
        -- markup / data
        'markdown', 'latex', 'rst',
        'json', 'jsonc',
        'yaml', 'toml', 'ini',
        -- git
        'diff',
        'gitignore',
        'gitcommit',
        'gitcommit',
        'git_rebase',
        'git_config',
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

    local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()

    parser_config.nu = {
      install_info = {
        url = "https://github.com/nushell/tree-sitter-nu",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "nu",
    }
  end
}
