require 'utils'

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
    asd = 'lisp',
    rkt = 'racket',
    cr = 'crystal',
  },
  filename = {
    ['go.mod'] = 'gomod',
    ['go.sum'] = 'gosum',
  },
}

-- augroups
vim.api.nvim_create_augroup('doongjohn:BufEnter', {})
vim.api.nvim_create_augroup('doongjohn:FileType', {})

-- set syntax
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'doongjohn:BufEnter',
  pattern = { '*.nims', '*.nimble' },
  callback = function()
    vim.opt.syntax = 'nim'
  end
})
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'doongjohn:BufEnter',
  pattern = { '*.vifm', 'vifmrc' },
  callback = function()
    vim.opt.syntax = 'vim'
  end
})

-- settings per filetype
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = { 'gitconfig', 'markdown', 'fish', 'python', 'cs', 'go', 'zig', 'odin' },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = { 'gitconfig', 'make', 'odin' },
  callback = function()
    vim.bo.expandtab = false
  end
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = { 'oil' },
  callback = function()
    vim.opt_local.cursorline = true
  end
})

-- plugins
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

-- setup winbar
local winbar_filetype_exclude = {
  'qf',
  'prompt',
  'terminal',
  'lazy',
  'notify',
  'toggleterm',
  'oil',
  'oil_preview',
  'neo-tree',
  'neo-tree-popup',
  'Outline',
  'OutlineHelp',
  'Trouble',
  'rgflow',
  'fzf',
  'Telescope',
  'TelescopePrompt',
  'TelescopeResults',
}
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'doongjohn:BufEnter',
  pattern = { '*' },
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= '' then
      return
    end
    if vim.api.nvim_buf_get_name(0):len() == 0 then
      vim.opt_local.winbar =
      [[%#TabLineSel# [No Name]%{&modified ? " *" : ""} %#Comment#]]
    end
  end
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = { '*' },
  callback = function()
    if vim.startswith(vim.api.nvim_buf_get_name(0), 'oil') then
      -- oil
      vim.opt_local.winbar =
          [[%#TabLineSel# oil%{&modified ? " *" : ""} %#Comment# ]] ..
          [[%{%luaeval("vim.api.nvim_buf_get_name(0):sub(7,-1)")%}]]
    elseif vim.bo.filetype == 'Outline' then
      -- outline
      vim.opt_local.winbar = [[%#TabLineSel# outline%{&modified ? " *" : ""} %#Comment#]]
    elseif not vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
      -- code
      vim.opt_local.winbar =
          [[%#TabLineSel# %t%{&modified ? " *" : ""} %#Comment# ]] ..
          [[%{%v:lua.require'nvim-navic'.get_location()%}]]
    else
      vim.opt_local.winbar = ''
    end
  end
})

-- esc
keymap('v', '<c-l>', '<esc>')
keymap('i', '<c-l>', '<esc>')
-- goto previous buffer
keymap_s('n', '<leader>\'', '<c-^>')
-- highlight current word
keymap_s('n', '<leader>a', '*N')
-- delete word right side of the cursor
keymap_s('i', '<c-d>', '<c-o>dw')
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
keymap_s('n', '<c-h>', vim.lsp.buf.hover)
keymap_s('i', '<c-h>', vim.lsp.buf.hover)
keymap_s('n', '<f2>', vim.lsp.buf.rename)
keymap_s('n', '<f12>', vim.lsp.buf.definition)

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
