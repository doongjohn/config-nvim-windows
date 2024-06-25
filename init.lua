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

-- setup lazy nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
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

-- setup winbar
local winbar_filetype_exclude = {
  'qf',
  'prompt',
  'terminal',
  'checkhealth',
  'lazy',
  'Trouble',
  'toggleterm',
  'oil',
  'oil_preview',
  'neo-tree',
  'neo-tree-popup',
  'buffer_manager',
  'fzf',
  'Telescope',
  'TelescopePrompt',
  'TelescopeResults',
  'Outline',
  'OutlineHelp',
  'rgflow',
  'dap-float',
}
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'doongjohn:BufEnter',
  pattern = { '*' },
  callback = function()
    if vim.bo.filetype == 'Outline' then
      vim.opt_local.winbar = [[%#TabLineSel# outline%{&modified ? " *" : ""} %#Comment#]]
    end
  end
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'doongjohn:FileType',
  pattern = { '*' },
  callback = function()
    if vim.startswith(vim.api.nvim_buf_get_name(0), 'oil') then
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

-- esc
vim.keymap.set('v', '<c-l>', '<esc>')
vim.keymap.set('i', '<c-l>', '<esc>')
-- goto alternate-file
vim.keymap.set('n', '<leader>\'', '<c-^>', { silent = true })
-- highlight current word
vim.keymap.set('n', '<leader>a', '*N', { silent = true })
-- delete word right side of the cursor
vim.keymap.set('i', '<c-d>', '<c-o>dw', { silent = true })
-- paste yanked
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
-- lsp functions
vim.keymap.set('n', '<f2>', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action)

-- multi-line normal command
vim.keymap.set('v', '<leader>z', function()
  local input = vim.fn.input('normal cmd:')
  if input == '' then return end

  -- get selected lines
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'x', false)
  local top = vim.api.nvim_buf_get_mark(0, '<')[1]
  local bot = vim.api.nvim_buf_get_mark(0, '>')[1]
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
