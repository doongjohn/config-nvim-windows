return {
  -- preview line number
  'nacro90/numb.nvim',
  event = 'BufEnter',
  config = function()
    require 'numb'.setup {}
  end
}
