require 'utils'
return {
  -- comment toggle
  'numtostr/comment.nvim',
  event = 'BufEnter',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require 'Comment'.setup {
      ignore = '^$', -- ignore whitespace
    }
    local comment_ft = require 'Comment.ft'
    comment_ft(
      { 'nasm', 'asm' },
      { ';%s', '/*%s*/' })
    comment_ft(
      { 'racket' },
      { ';;%s', '#|%s|#' })
    comment_ft(
      { 'nim', 'nims' },
      { '#%s', '#[%s]#' })
    comment_ft(
      { 'glsl', 'odin', 'v' },
      { '//%s', '/*%s*/' })

    keymap_rs('n', '<c-/>', 'gcc')
    keymap_rs('i', '<c-/>', '<esc>gccgi')
    keymap_rs('v', '<c-/>', 'gcgv')
  end
}
