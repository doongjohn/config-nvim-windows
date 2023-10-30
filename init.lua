-- disable default filetype script
vim.g.did_load_filetypes = 1

vim.o.clipboard = 'unnamed'

-- enable mouse input
vim.o.mouse = 'a'

-- ui settings
vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.number = true
vim.o.signcolumn = 'yes:1'
vim.o.showmode = false
vim.o.sidescrolloff = 8
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.laststatus = 3
vim.o.splitkeep = 'screen'
vim.opt.fillchars:append {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
  eob       = ' ',
}
vim.o.wrap = false

-- show trailing whitespace
vim.o.list = true
vim.o.listchars = 'trail:·,tab:  '

-- use 2 spaces for indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- augroups
vim.api.nvim_create_augroup('FtInit', {})

-- plugins
require 'lazy'.setup({
  import = 'plugins'
}, {
  defaults = {
    lazy = true,
  },
  performance = {
    rtp = {
      reset = true,
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

require 'utils'

-- esc
keymap('v', '<c-l>', '<esc>')
keymap('i', '<c-l>', '<esc>')
-- goto previous buffer
keymap_s('n', '<leader>\'', '<c-^>')
-- highlight current word
keymap_s('n', '<leader>a', '*N')
-- delete word right side of the cursor
keymap_s('i', '<c-d>', '<c-o>dw')
-- cut text
keymap_s('n', '<c-x>', 'yydd')
-- paste yanked
keymap_s('n', '<leader>p', '"0p')
keymap_s('v', '<leader>p', '"0p')
-- indent using tab
keymap_s('v', '<tab>', '>gv')
keymap_s('v', '<s-tab>', '<gv')
-- move text up down
keymap_s('n', '<a-j>', "v:move '>+1<cr>")
keymap_s('n', '<a-k>', "v:move '<-2<cr>")
keymap_s('n', '<a-down>', "v:move '>+1<cr>")
keymap_s('n', '<a-up>', "v:move '<-2<cr>")
keymap_s('v', '<a-j>', ":move '>+1<cr>gv-gv")
keymap_s('v', '<a-k>', ":move '<-2<cr>gv-gv")
keymap_s('v', '<a-down>', ":move '>+1<cr>gv-gv")
keymap_s('v', '<a-up>', ":move '<-2<cr>gv-gv")
-- lsp functions
keymap_s('n', '<c-h>', '<cmd>lua vim.lsp.buf.hover()<cr>')
keymap_s('i', '<c-h>', '<cmd>lua vim.lsp.buf.hover()<cr>')
keymap_s('n', '<f2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
keymap_s('n', '<f12>', '<cmd>lua vim.lsp.buf.definition()<cr>')

-- multi-line normal command
keymap_s('v', '<leader>z', function()
  local input = vim.fn.input('normal cmd:')
  if input == '' then
    return
  end

  -- get selection range
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'x', false)
  local top = vim.api.nvim_buf_get_mark(0, '<')[1]
  local bot = vim.api.nvim_buf_get_mark(0, '>')[1]

  -- get selected lines
  local selected_lines = vim.api.nvim_buf_get_lines(0, top - 1, bot, false)

  -- create hidden buffer
  local hidden_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_call(hidden_buf, function()
    -- iterate over lines and run normal command
    for i, line in ipairs(selected_lines) do
      if i == 1 then
        vim.api.nvim_buf_set_lines(hidden_buf, 0, 1, false, { line })
      else
        local line_count = vim.api.nvim_buf_line_count(hidden_buf)
        vim.api.nvim_buf_set_lines(hidden_buf, line_count, line_count, false, { line })
      end
      vim.cmd([[exe "norm G0]] .. input .. [[\<esc>"]])
    end
  end)

  -- replace text
  vim.api.nvim_buf_set_lines(0, top - 1, bot, false, vim.api.nvim_buf_get_lines(hidden_buf, 0, -1, false))

  -- delete hidden buffer
  vim.api.nvim_buf_delete(hidden_buf, { force = true })
end)
