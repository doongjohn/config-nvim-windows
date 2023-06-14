return {
  -- comment toggle
  'numtostr/comment.nvim',
  event = 'BufEnter',
  keys = {
    { '<c-/>', 'gcc', mode = 'n' },
    { '<c-/>', '<esc>gccgi', mode = 'i' },
    { '<c-/>', 'gcgv', mode = 'v' },
  },
  config = function()
    require 'Comment'.setup {
      ignore = '^$', -- ignore whitespace
    }
    local comment_ft = require 'Comment.ft'
    comment_ft(
      { 'nasm', 'asm' },
      { ';%s', '/*%s*/' })
    comment_ft(
      { 'nim' },
      { '#%s', '#[%s]#' })
    comment_ft(
      { 'glsl', 'odin', 'v' },
      { '//%s', '/*%s*/' })
  end
}
