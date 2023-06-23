return {
  -- better diagnostic code lens
  url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = 'BufEnter',
  config = function()
    require 'lsp_lines'.setup()
  end
}
