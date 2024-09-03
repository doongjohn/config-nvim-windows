os.setlocale('ko_KR.UTF8')

vim.o.clipboard = 'unnamedplus'
vim.o.jumpoptions = 'stack,view'
vim.o.mouse = 'a'
vim.o.wrap = false
vim.o.sidescrolloff = 10
vim.o.number = true
vim.o.signcolumn = 'yes:1'
vim.o.showmode = false
vim.o.laststatus = 3
vim.o.syntax = 'on'

-- show whitespace
vim.o.list = true
vim.opt.listchars:append {
  trail = '·',
  tab = '  ',
}

-- split options
vim.o.splitright = true
vim.o.splitbelow = true
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

-- use 2 spaces for indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- leader key
vim.g.maplocalleader = ','

-- filetypes
vim.filetype.add {
  extension = {
    make = 'make',
    asm = 'nasm',
    h = 'cpp', -- this is unfortunate
    hpp = 'cpp',
    d = 'd',
    nim = 'nim',
    nims = 'nims',
    nimble = 'nimble',
    cr = 'crystal',
    asd = 'lisp',
  },
  filename = {
    ['go.mod'] = 'gomod',
    ['go.sum'] = 'gosum',
  },
}

-- augroup
vim.api.nvim_create_augroup('config', {})

-- setup diagnostic
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
local diag_icons = {
  { type = 'Error', icon = '󰅚 ' },
  { type = 'Warn', icon = '󰀪 ' },
  { type = 'Info', icon = '󰋽 ' },
  { type = 'Hint', icon = '󰌶 ' },
}
for _, v in pairs(diag_icons) do
  vim.fn.sign_define(
    'DiagnosticSign' .. v.type,
    {
      text = v.icon,
      texthl = 'DiagnosticSign' .. v.type,
      linehl = '',
      numhl = 'Diagnostic' .. v.type,
    })
end

HighlighterSkip = false

require 'highlighter'
require 'languages'
require 'winbar'

-- keymaps
do
  -- esc
  vim.keymap.set('v', '<c-l>', '<esc>')
  vim.keymap.set('i', '<c-l>', '<esc>')

  -- inner line
  vim.keymap.set('v', 'il', ':<c-u>norm ^vg_<cr>')
  vim.keymap.set('o', 'il', '<cmd>norm ^vg_<cr>')

  -- search word under cursor
  vim.keymap.set('n', '<leader>s', function()
    local view = vim.fn.winsaveview()
    vim.cmd('norm *')
    vim.fn.winrestview(view)
  end, { silent = true })

  -- search selected
  vim.keymap.set('v', '<leader>s', function()
    local view = vim.fn.winsaveview()
    vim.cmd(vim.api.nvim_replace_termcodes([[norm ""y/<c-r>"<cr>]], true, false, true))
    vim.fn.winrestview(view)
  end, { silent = true })

  -- paste yanked text
  vim.keymap.set('n', '<leader>p', '"0p', { silent = true })
  vim.keymap.set('v', '<leader>p', '"0p', { silent = true })

  -- indent using tab
  vim.keymap.set('v', '<tab>', '>gv', { silent = true })
  vim.keymap.set('v', '<s-tab>', '<gv', { silent = true })

  -- move text up down
  vim.keymap.set('n', '<a-j>', "v:move '>+1<cr>", { silent = true })
  vim.keymap.set('n', '<a-k>', "v:move '<-2<cr>", { silent = true })
  vim.keymap.set('v', '<a-j>', ":move '>+1<cr>gv-gv", { silent = true })
  vim.keymap.set('v', '<a-k>', ":move '<-2<cr>gv-gv", { silent = true })

  -- lsp
  vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, { silent = true })

  -- string to array
  vim.keymap.set('v', '<leader>,', [[:s/\%V\(.\)/'\1', /g<cr>]])
end

-- setup lazy nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup({
  spec = {
    { import = 'plugins' },
  },
  ui = {
    backdrop = 100,
  },
  change_detection = {
    notify = false,
  },
  defaults = {
    lazy = true,
  },
  rocks = {
    enabled = false,
  },
  performance = {
    rtp = {
      reset = true,
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        'netrwPlugin',
      },
    },
  },
})
