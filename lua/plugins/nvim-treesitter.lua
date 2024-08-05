return {
  -- treesitter
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nushell/tree-sitter-nu',
  },
  build = ':TSUpdate',
  -- event = { 'BufReadPost', 'BufNewFile' },
  event = 'UIEnter',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require 'nvim-treesitter.configs'.setup {
      sync_install = false,
      ensure_installed = {
        -- shell
        'bash', 'fish', 'nu',
        -- tool
        'make', 'cmake', 'ninja',
        'regex', 'vim', 'vimdoc',
        -- compiled lanuage
        'c', 'cpp', 'c_sharp',
        'rust', 'zig', 'odin',
        'go', 'gomod', 'gosum', 'gowork',
        'nim', 'nim_format_string',
        'commonlisp',
        -- scripting lanuage
        'python', 'ruby', 'julia',
        'lua', 'fennel',
        -- web dev
        'html', 'css', 'scss',
        'javascript', 'jsdoc',
        'typescript', 'tsx',
        'astro', 'svelte', 'vue',
        -- shader
        'wgsl', 'glsl', 'hlsl',
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
