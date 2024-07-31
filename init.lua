vim.o.clipboard = 'unnamedplus'
vim.o.jumpoptions = 'stack,view'
vim.o.mouse = 'a'
vim.o.wrap = false
vim.o.sidescrolloff = 10
vim.o.syntax = 'on'
vim.o.number = true
vim.o.showmode = false
vim.o.laststatus = 3
vim.o.signcolumn = 'yes:1'

-- show whitespace
vim.o.list = true
vim.opt.listchars:append('trail:·')
vim.opt.listchars:append('tab:  ')

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
    cr = 'crystal',
  },
  filename = {
    ['go.mod'] = 'gomod',
    ['go.sum'] = 'gosum',
  },
}

-- local leader
vim.g.maplocalleader = ','

-- augroups
vim.api.nvim_create_augroup('doongjohn:BufEnter', {})
vim.api.nvim_create_augroup('doongjohn:BufWinEnter', {})
vim.api.nvim_create_augroup('doongjohn:FileType', {})
vim.api.nvim_create_augroup('doongjohn:LspTokenUpdate', {})

-- syntax per filetype
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'doongjohn:BufEnter',
  pattern = {
    '*.nims',
    '*.nimble',
  },
  callback = function()
    vim.opt.syntax = 'nim'
  end
})
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'doongjohn:BufEnter',
  pattern = {
    '*.vifm',
    'vifmrc',
  },
  callback = function()
    vim.opt.syntax = 'vim'
  end
})

-- options per filetype
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = { 'toggleterm' },
  callback = function()
    vim.opt_local.signcolumn = 'no'
  end
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = {
    'gitconfig',
    'make',
    'go',
    'odin',
  },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = false
  end
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = {
    'markdown',
    'fish',
    'nu',
    'python',
    'cs',
    'zig',
    'glsl',
  },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = { 'oil' },
  callback = function()
    vim.opt_local.cursorline = true
  end
})

-- comment string per filetype
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = {
    'c',
    'cpp',
    'odin',
  },
  callback = function()
    vim.bo.commentstring = '// %s';
  end
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = {
    'nim',
    'nims',
    'nimble',
  },
  callback = function()
    vim.bo.commentstring = '# %s';
  end
})

-- zig: disable opening quickfix on error
vim.g.zig_fmt_parse_errors = 0

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

-- setup winbar
local winbar_filetype_exclude = {
  'qf',
  'prompt',
  'terminal',
  'checkhealth',
  'oil',
  'neo-tree',
  'toggleterm',
  'Outline',
  'Trouble',
  'NeogitStatus',
}
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = { '*' },
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= "" then
      -- ignore floating window
      return
    elseif vim.startswith(vim.api.nvim_buf_get_name(0), 'oil') then
      vim.opt_local.winbar =
          [[%#TabLineSel# oil%{&modified ? " *" : ""} %#Comment# ]] ..
          [[%{%luaeval("vim.api.nvim_buf_get_name(0):sub(7,-1)")%}]]
    elseif not vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
      vim.opt_local.winbar =
          [[%#TabLineSel# %t%{&modified ? " *" : ""} %#Comment# ]] ..
          [[%{%v:lua.require'nvim-navic'.get_location()%}]]
    end
  end
})
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'doongjohn:BufEnter',
  pattern = { '*' },
  callback = function()
    if vim.bo.filetype == 'Outline' then
      vim.opt_local.winbar = [[%#TabLineSel# outline%{&modified ? " *" : ""} %#Comment#]]
    end
  end
})

-- keymaps
do
  -- esc
  vim.keymap.set('v', '<c-l>', '<esc>')
  vim.keymap.set('i', '<c-l>', '<esc>')
  -- goto alternate-file
  vim.keymap.set('n', '<leader>\'', '<c-^>', { silent = true })
  -- highlight current word
  vim.keymap.set('n', '<leader>a', function()
    local view = vim.fn.winsaveview()
    vim.cmd 'norm *N'
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
  vim.keymap.set('n', '<a-down>', "v:move '>+1<cr>", { silent = true })
  vim.keymap.set('n', '<a-up>', "v:move '<-2<cr>", { silent = true })
  vim.keymap.set('v', '<a-j>', ":move '>+1<cr>gv-gv", { silent = true })
  vim.keymap.set('v', '<a-k>', ":move '<-2<cr>gv-gv", { silent = true })
  vim.keymap.set('v', '<a-down>', ":move '>+1<cr>gv-gv", { silent = true })
  vim.keymap.set('v', '<a-up>', ":move '<-2<cr>gv-gv", { silent = true })
  -- lsp
  vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, { silent = true })
end

-- neovide settings
if vim.g.neovide then
  vim.g.neovide_fullscreen = true
  vim.g.neovide_padding_top = 10
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_scroll_animation_length = 0.15
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.2
  vim.g.neovide_cursor_vfx_mode = 'wireframe'
  vim.o.guifont = 'Hack_Nerd_Font,Sarasa_Fixed_K,Segoe_UI_Emoji:h14'
  vim.o.linespace = 6
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
      },
    },
  },
})
