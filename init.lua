vim.o.clipboard = 'unnamedplus'

vim.g.did_load_filetypes = 1

vim.o.mouse = 'a'

vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.number = true
vim.o.signcolumn = 'yes:1'
vim.o.showmode = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.laststatus = 3
vim.opt.fillchars:append {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}
vim.opt_local.scrolloff = 4
vim.o.wrap = false

-- show trailing whitespace
vim.o.list = true
vim.o.listchars = 'trail:·,tab:  '

-- use 2 spaces for indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- keymap
local keymap_str = vim.api.nvim_set_keymap
local keymap_fun = vim.keymap.set
local keymap_opt_n = { noremap = true }
local keymap_opt_r = { noremap = false }
local keymap_opt_ns = { noremap = true, silent = true }
local keymap_opt_rs = { noremap = false, silent = true }
local function keymap_n(mode, key, cmd) keymap_str(mode, key, cmd, keymap_opt_n) end
local function keymap_r(mode, key, cmd) keymap_str(mode, key, cmd, keymap_opt_r) end
local function keymap_ns(mode, key, cmd) keymap_str(mode, key, cmd, keymap_opt_ns) end
local function keymap_rs(mode, key, cmd) keymap_str(mode, key, cmd, keymap_opt_rs) end
local function keymap_fun_n(mode, key, cmd) keymap_fun(mode, key, cmd, keymap_opt_n) end
local function keymap_fun_r(mode, key, cmd) keymap_fun(mode, key, cmd, keymap_opt_r) end
local function keymap_fun_ns(mode, key, cmd) keymap_fun(mode, key, cmd, keymap_opt_ns) end
local function keymap_fun_rs(mode, key, cmd) keymap_fun(mode, key, cmd, keymap_opt_rs) end

keymap_ns('v', 'x', 'ygvd')
keymap_ns('n', '<c-x>', 'yydd')

if vim.g.vscode then
  -- keymap: hover
  keymap_ns('n', '<c-h>', "<cmd>call VSCodeNotify('editor.action.showHover')<cr>")

  -- keymap: fuzzy file search
  keymap_ns('n', '<space>', "<cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>")

  -- keymap: toggle terminal
  keymap_ns('n', '<c-k>', "<cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<cr>")

  -- keymap: delete current buffer
  keymap_ns('n', '<leader>d', "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>")

  -- keymap: goto previous buffer
  keymap_ns('n', '<c-b>', "<cmd>call VSCodeNotify('workbench.action.openPreviousRecentlyUsedEditor')<cr>")

  -- keymap: cut text
  keymap_ns('v', 'x', "ygvd")
  keymap_ns('n', '<c-x>', "<cmd>call VSCodeNotify('editor.action.clipboardCutAction')<cr>")

  -- keymap: easy motion
  keymap_ns('n', 'm', "<cmd>call VSCodeNotify('findThenJump.initiate')<cr>")

  -- fold action
  keymap_ns('n', 'za', "<cmd>call VSCodeNotify('editor.toggleFold')<cr>")
  keymap_ns('n', 'zR', "<cmd>call VSCodeNotify('editor.unfoldAll')<cr>")
  keymap_ns('n', 'zM', "<cmd>call VSCodeNotify('editor.foldAll')<cr>")
  keymap_ns('n', 'zo', "<cmd>call VSCodeNotify('editor.unfold')<cr>")
  keymap_ns('n', 'zO', "<cmd>call VSCodeNotify('editor.unfoldRecursively')<cr>")
  keymap_ns('n', 'zc', "<cmd>call VSCodeNotify('editor.fold')<cr>")
  keymap_ns('n', 'zC', "<cmd>call VSCodeNotify('editor.foldRecursively')<cr>")

  keymap_ns('n', 'z1', "<cmd>call VSCodeNotify('editor.foldLevel1')<cr>")
  keymap_ns('n', 'z2', "<cmd>call VSCodeNotify('editor.foldLevel2')<cr>")
  keymap_ns('n', 'z3', "<cmd>call VSCodeNotify('editor.foldLevel3')<cr>")
  keymap_ns('n', 'z4', "<cmd>call VSCodeNotify('editor.foldLevel4')<cr>")
  keymap_ns('n', 'z5', "<cmd>call VSCodeNotify('editor.foldLevel5')<cr>")
  keymap_ns('n', 'z6', "<cmd>call VSCodeNotify('editor.foldLevel6')<cr>")
  keymap_ns('n', 'z7', "<cmd>call VSCodeNotify('editor.foldLevel7')<cr>")

  keymap_ns('n', '<a-down>', "<cmd>call VSCodeNotify('editor.action.moveLinesDownAction')<cr>")
  keymap_ns('n', '<a-up>', "<cmd>call VSCodeNotify('editor.action.moveLinesUpAction')<cr>")
  keymap_ns('v', '<a-down>', "<cmd>call VSCodeNotifyVisual('editor.action.moveLinesDownAction', 1)<cr>")
  keymap_ns('v', '<a-up>', "<cmd>call VSCodeNotifyVisual('editor.action.moveLinesUpAction', 1)<cr>")

  function MoveVisualSelection(direction)
    -- vim.pretty_print(vim.fn.line('.'))
    -- vim.pretty_print(vim.fn.line('v'))

    local cursorLine = vim.fn.line('v')
    local cursorStartLine = vim.fn.line('.')

    local startLine = cursorLine
    local endLine = cursorStartLine

    if direction == "Up" then
      if startLine < endLine then
        local tmp = startLine
        startLine = endLine
        endLine = tmp
      end
    else -- == "Down"
      if startLine > endLine then
        local tmp = startLine
        startLine = endLine
        endLine = tmp
      end
    end

    -- move lines
    vim.cmd("call VSCodeCallRange('editor.action.moveLines" .. direction .. "Action'," .. startLine .. "," .. endLine .. ",1)")

    -- move visual selection
    if direction == "Up" then
      if endLine > 1 then
        startLine = startLine - 1
        endLine = endLine - 1

        -- exit visual mode
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), 'x', true)

        -- select range
        vim.cmd("normal!" .. startLine .. "GV" .. endLine .. "G")
        -- vim.api.nvim_command(tostring(endLine)) -- move cursor
        -- vim.api.nvim_feedkeys("V", 'n', false) -- enter visual line mode
        -- vim.api.nvim_command(tostring(startLine)) -- move cursor
      end
    else -- == "Down"
      if endLine < vim.api.nvim_buf_line_count(0) then
        startLine = startLine + 1
        endLine = endLine + 1

        -- exit visual mode
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), 'x', true)

        -- select range
        vim.cmd("normal!" .. startLine .. "GV" .. endLine .. "G")
      end
    end
  end

  keymap_fun_ns('v', '<a-up>', function() MoveVisualSelection('Up') end)
  keymap_fun_ns('v', '<a-down>', function() MoveVisualSelection('Down') end)
end

-- plugins
require'paq' {
  'savq/paq-nvim';
  'lewis6991/impatient.nvim';
  'nathom/filetype.nvim';
  'rebelot/kanagawa.nvim';
  'kevinhwang91/nvim-hclipboard';
  'numtostr/comment.nvim';
  'kylechui/nvim-surround';
  'matze/vim-move';
}

require 'impatient'

local hclipboard = require'hclipboard'.setup {
  -- don't copy on (c)hange & (d)elete
  -- use x for cut (normal mode x does not copy)
  should_bypass_cb = function(regname, ev)
    local ret = false
    if ev.operator == 'c' or ev.operator == 'd' then
      if ev.regname == '' or ev.regname == regname then
        ret = true
      end
    end
    return ret
  end
}
hclipboard.start()

require'Comment'.setup {
  ignore = '^$', -- ignore whitespace
}
local comment_ft = require'Comment.ft'
comment_ft({ 'nim' }, { '#%s', '#[%s]#' })
comment_ft({ 'glsl', 'odin', 'v' }, { '//%s', '/*%s*/' })

keymap_rs('n', '<c-_>', 'gcc')
keymap_rs('i', '<c-_>', '<esc>gccgi')
keymap_rs('v', '<c-_>', 'gc')

require'nvim-surround'.setup {}

if not vim.g.vscode then
  -- colorscheme
  require 'kanagawa'.setup {
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
    statementStyle = { bold = false },
    variablebuiltinStyle = { italic = false },
  }
  vim.o.background = 'dark'
  vim.cmd 'colorscheme kanagawa'
  local colors = require 'kanagawa.colors'.setup()

  -- vim-move
  keymap_ns('n', '<a-down>', '<plug>MoveLineDown')
  keymap_ns('n', '<a-up>', '<Plug>MoveLineUp')
  keymap_ns('v', '<a-down>', '<Plug>MoveBlockDown')
  keymap_ns('v', '<a-up>', '<Plug>MoveBlockUp')
end
