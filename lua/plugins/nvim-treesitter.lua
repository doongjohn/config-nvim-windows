return {
  -- treesitter
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    sync_install = false,
    ensure_installed = {
      'c', 'cpp', 'llvm',
      'rust', 'zig', 'odin',
      'go', 'gomod', 'gosum', 'gowork',
      'c_sharp', 'ocaml',
      'commonlisp', 'racket',
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
      -- other
      'make', 'cmake', 'ninja',
      'regex', 'comment',
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
  },
}
