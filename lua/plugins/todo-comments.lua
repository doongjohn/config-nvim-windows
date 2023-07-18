require 'utils'
return {
  -- highlight and list todo comments
  'folke/todo-comments.nvim',
  lazy = false,
  cmd = 'TodoLocList',
  config = function()
    vim.cmd 'hi clear Todo' -- clear default todo highlight
    require 'todo-comments'.setup {
      signs = false,
      highlight = {
        pattern = [[(KEYWORDS)\s*(\([^\)]*\))?:]],
      },
      search = {
        command = "rg",
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--glob=!cache',
          '--glob=!vendor',
          '--glob=!build',
          '--glob=!target',
          '--glob=!bin',
          '--glob=!out',
          '--glob=!dep',
          '--glob=!deps',
          '--glob=!lib',
          '--glob=!libs',
          '--glob=!dist',
          '--glob=!node_modules',
          '--glob=!zig-cache',
          '--glob=!zig-out',
        },
        pattern = [[\b(KEYWORDS)\s*(\([^\)]*\))?:]],
      },
    }
  end
}
