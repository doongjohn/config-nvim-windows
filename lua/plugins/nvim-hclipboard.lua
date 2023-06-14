return {
  'kevinhwang91/nvim-hclipboard',
  event = 'BufEnter',
  config = function()
    local hclipboard = require 'hclipboard'.setup {
      -- don't copy on (c)hange & (d)elete
      -- use x for cut (only for visual mode)
      should_bypass_cb = function(regname, ev)
        local result = false
        if ev.operator == 'c' or ev.operator == 'd' then
          if ev.regname == '' or ev.regname == regname then
            result = true
          end
        end
        return result
      end
    }
    if hclipboard then
      hclipboard.start()
    end
  end
}
