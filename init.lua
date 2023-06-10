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

-- keymap
local function keymap(mode, key, cmd) vim.keymap.set(mode, key, cmd, { remap = false}) end
local function keymap_r(mode, key, cmd) vim.keymap.set(mode, key, cmd, { remap = true }) end
local function keymap_s(mode, key, cmd) vim.keymap.set(mode, key, cmd, { remap = false, silent = true }) end
local function keymap_rs(mode, key, cmd) vim.keymap.set(mode, key, cmd, { remap = true, silent = true }) end

-- highlight current word
keymap_s('n', '<leader>a', '*N')
-- delete word right side of the cursor
keymap_s('i', '<c-d>', '<c-o>dw')
-- cut text
keymap_s('v', 'x', 'ygvd')
keymap_s('n', '<c-x>', 'yydd')
-- indent using tab
keymap_s('v', '<tab>', '>gv')
keymap_s('v', '<s-tab>', '<gv')

-- plugins
require'paq' {
  'savq/paq-nvim',

  -- performance
  'lewis6991/impatient.nvim',
  'nathom/filetype.nvim',

  -- dependencies
  'nvim-tree/nvim-web-devicons',
  'nvim-lua/plenary.nvim',
  'muniftanjim/nui.nvim',

  -- colorscheme
  'rebelot/kanagawa.nvim',

  -- better editing
  'kevinhwang91/nvim-hclipboard',
  'cappyzawa/trim.nvim',
  'numtostr/comment.nvim',
  'kylechui/nvim-surround',
  'gpanders/nvim-parinfer',
  'ggandor/leap.nvim',
  'mg979/vim-visual-multi',

  -- better UI/UX
  'ojroques/nvim-bufdel',
  'lukas-reineke/indent-blankline.nvim',
  'nvim-lualine/lualine.nvim',
  'nvim-neo-tree/neo-tree.nvim',
  'akinsho/toggleterm.nvim',
  'nvim-telescope/telescope.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = [[cmd ~\AppData\Local\nvim\telescope-fzf.cmd]],
  },
  {
    'nvim-treesitter/nvim-treesitter',
    run = function() vim.cmd('TSUpdate') end,
  },

  -- code completion
  'dcampos/nvim-snippy',
  'dcampos/cmp-snippy',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',

  -- lsp
  'neovim/nvim-lspconfig',

  -- languages
  'folke/neodev.nvim',
}

require 'impatient'

require 'filetype'.setup {
  overrides = {
    extensions = {
      sh = 'sh',
      bash = 'bash',
      make = 'make',
      asm = 'nasm',
      c = 'c',
      h = 'cpp', -- this is unfortunate
      cc = 'cpp',
      hpp = 'cpp',
      rkt = 'racket',
      nim = 'nim',
      nims = 'nims',
      nimble = 'nimble',
      html = 'html',
    },
    literal = {
      ['.bashrc'] = 'bash',
      ['.profile'] = 'bash',
      ['go.mod'] = 'gomod',
      ['go.sum'] = 'gosum',
    },
  },
}

local hclipboard = require 'hclipboard'.setup {
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
if hclipboard then
  hclipboard.start()
end

require 'Comment'.setup {
  ignore = '^$', -- ignore whitespace
}
local comment_ft = require'Comment.ft'
comment_ft(
{ 'nim' },
{ '#%s', '#[%s]#' }
)
comment_ft(
{ 'glsl', 'odin', 'v' },
{ '//%s', '/*%s*/' }
)
keymap_rs('n', '<c-_>', 'gcc')
keymap_rs('i', '<c-_>', '<esc>gccgi')
keymap_rs('v', '<c-_>', 'gc')

require 'nvim-surround'.setup {}

-- colorscheme
local kanagawa = require 'kanagawa'
kanagawa.setup {
  commentStyle = { bold = false, italic = false },
  keywordStyle = { bold = false, italic = false },
  statementStyle = { bold = false, italic = false },
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    }
  },
  overrides = function(colors)
    local theme = colors.theme
    local palette = colors.palette

    return {
      -- popup menu
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
      -- telescope
      TelescopeNormal = { bg = palette.sumiInk0 },
      TelescopeTitle = { bg = palette.sumiInk5, fg = palette.dragonBlue, bold = true },
      TelescopeResultsTitle = { bg = palette.sumiInk2, fg = palette.dragonBlue },
      TelescopeBorder = { bg = palette.sumiInk0, fg = palette.sumiInk0 },
      TelescopePromptPrefix = { bg = palette.sumiInk4, fg = palette.autumnRed },
      TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
      TelescopeSelection = { bg = palette.sumiInk5 },
    }
  end,
}

vim.o.background = 'dark'
vim.cmd.colorscheme('kanagawa-wave')
local palette = require 'kanagawa.colors'.setup().palette

-- extra colors
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = palette.sumiInk4 })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = palette.sumiInk0, fg = palette.sumiInk0 })
vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = palette.sumiInk0, fg = palette.fujiWhite })

vim.api.nvim_set_hl(0, '@namespace', { link = 'Constant' })
vim.api.nvim_set_hl(0, '@parameter', { fg = palette.oldWhite })
vim.api.nvim_set_hl(0, '@variable.builtin', { fg = palette.waveRed })
-- semantic highlighting: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
vim.api.nvim_set_hl(0, '@lsp.type.comment', { link = '@comment' })
vim.api.nvim_set_hl(0, '@lsp.type.keyword', { link = '@keyword' })
vim.api.nvim_set_hl(0, '@lsp.mod.namespace', { link = 'Constant' })

-- delete buffer
keymap_s('n', '<leader>d', '<cmd>BufDel<cr>')

-- goto previous buffer
keymap_s('n', '<leader>\'', '<c-^>')

-- move text up down
keymap_s("n", "<a-j>", "V:move '>+1<cr>gv-gv")
keymap_s("n", "<a-k>", "V:move '<-2<cr>gv-gv")
keymap_s("n", "<a-down>", "V:move '>+1<cr>gv-gv")
keymap_s("n", "<a-up>", "V:move '<-2<cr>gv-gv")
keymap_s("x", "<a-j>", ":move '>+1<cr>gv-gv")
keymap_s("x", "<a-k>", ":move '<-2<cr>gv-gv")
keymap_s("x", "<a-down>", ":move '>+1<cr>gv-gv")
keymap_s("x", "<a-up>", ":move '<-2<cr>gv-gv")

-- trim white space
require 'trim'.setup {
  ft_blocklist = {
    'markdown',
  },
  patterns = {
    [[%s/\s\+$//e]],
    [[%s/\($\n\s*\)\+\%$//]],
    [[%s/\%^\n\+//]],
  },
}

-- leap
local leap = require 'leap'
leap.setup {}
leap.opts.highlight_unlabeled_phase_one_targets = true
vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
vim.api.nvim_set_hl(0, 'LeapMatch', {
  fg = 'white',
  bold = true,
  nocombine = true,
})
local function leapSearch()
  leap.leap { target_windows = vim.tbl_filter(
  function(win) return vim.api.nvim_win_get_config(win).focusable end,
  vim.api.nvim_tabpage_list_wins(0)
  ) }
end
keymap_s('n', 'm', leapSearch)
keymap_s('v', 'm', leapSearch)
keymap_s('o', 'm', leapSearch)

-- vim visual multi
vim.g.VM_theme = 'iceblue'
vim.g.VM_leader = '\\'

-- bufdel
keymap_s('n', '<leader>d', '<cmd>BufDel<cr>')

-- indent guides
require 'indent_blankline'.setup {
  show_trailing_blankline_indent = false,
  max_indent_increase = 1,
  filetype_exclude = {
    'help',
    'prompt',
    'terminal',
    'lspinfo',
    'man',
    'neo-tree',
    'neo-tree-popup',
    'toggleterm',
    'TelescopePrompt',
    'TelescopeResult',
    'Trouble',
  },
}
-- update indent-blankline on fold open and close
keymap_s('n', 'zo', 'zo:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zO', 'zO:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zc', 'zc:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zC', 'zC:IndentBlanklineRefresh<cr>')
keymap_s('n', 'za', 'za:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zA', 'zA:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zv', 'zv:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zx', 'zx:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zX', 'zX:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zm', 'zm:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zM', 'zM:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zr', 'zr:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zR', 'zR:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zn', 'zn:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zN', 'zN:IndentBlanklineRefresh<cr>')
keymap_s('n', 'zi', 'zi:IndentBlanklineRefresh<cr>')

-- lualine
require 'lualine'.setup {
  options = {
    globalstatus = true,
    component_separators = { left = '│', right = '│' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      -- filetype
    },
  },
}

-- neo-tree
require 'neo-tree'.setup {
  close_if_last_window = true,
  popup_border_style = 'solid',
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      with_markers = true,
      indent_marker = '│',
      last_indent_marker = '└',
      highlight = 'NeoTreeIndentMarker',
    },
    icon = {
      folder_closed = '',
      folder_open = '',
      folder_empty = "",
      default = '',
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
    },
    git_status = {
      highlight = 'NeoTreeDimText', -- if you remove this the status will be colorful
      symbols = {
        -- Change type
        added     = "",
        modified  = "",
        deleted   = "",
        renamed   = "",
        -- Status type
        untracked = "?",
        ignored   = "󰔌",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      },
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    }
  },
}

keymap_s('n', '<leader>e', '<cmd>Neotree show current<cr>')
keymap_s('n', '<leader>E', '<cmd>Neotree show current reveal=true<cr>')

-- toggle term
local toggleterm = require 'toggleterm'
toggleterm.setup {
  shade_terminals = false,
  shell = 'nu',
}

local function toggleTerm()
  if vim.api.nvim_win_get_config(0).relative ~= '' then
    return
  end
  if vim.bo.filetype == 'fzf' then
    return
  end
  vim.cmd 'ToggleTerm direction=horizontal'
end

keymap_s('n', '<c-k>', toggleTerm)
keymap_s('t', '<c-k>', toggleTerm)

-- telescope
local telescope = require 'telescope'
local telescope_actions = require 'telescope.actions'
telescope.setup {
  defaults = {
    border = {},
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    path_display = { 'truncate' },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--hidden',
      '--trim',
      "-g '!build'",
    },
    mappings = {
      i = {
        ['<esc>'] = telescope_actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {
        'fd', '-tf', '-u',
        '--strip-cwd-prefix',

        -- exclude files
        '-E=*.a',
        '-E=*.o',
        '-E=*.so',
        '-E=*.obj',
        '-E=*.lib',
        '-E=*.dll',
        '-E=*.exe',

        -- exclude folders
        '-E=.objs',
        '-E=.deps',
        '-E=.cache',
        '-E=.git',
        '-E=.github',
        '-E=cache',
        '-E=vendor',
        '-E=dep',
        '-E=deps',
        '-E=lib',
        '-E=libs',
        '-E=out',
        '-E=build',
        '-E=target',
        '-E=dist',
        '-E=node_modules',
        '-E=zig-cache',
        '-E=zig-out',
      },
      hidden = true
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'ignore_case',
    },
  }
}
telescope.load_extension 'fzf'

keymap_s('n', '<space>', '<cmd>Telescope find_files<cr>')

-- tree-sitter
require 'nvim-treesitter.configs'.setup {
  sync_install = false,
  ensure_installed = {
    'c', 'cpp', 'llvm',
    'rust', 'zig', 'odin',
    'go', 'gomod', 'gosum', 'gowork',
    'c_sharp', 'ocaml',
    'commonlisp', 'racket',
    -- shader
    'wgsl', 'glsl', 'hlsl',
    -- web dev
    'html', 'css', 'scss',
    'javascript', 'jsdoc',
    'typescript', 'tsx',
    'astro', 'svelte', 'vue',
    -- scripting
    'bash', 'fish',
    'python', 'julia',
    'lua', 'fennel', 'vim',
    -- markup / data
    'markdown', 'latex', 'rst',
    'json', 'jsonc',
    'yaml', 'toml', 'ini',
    -- git
    'diff',
    'gitignore',
    'gitcommit',
    'gitcommit',
    'git_rebase',
    'git_config',
    'gitattributes',
    -- other
    'make', 'cmake', 'ninja',
    'regex', 'comment',
  },
  ignore_install = {
    -- 'somelanguage'
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = {
      -- 'somelanguage'
    },
  },
  indent = {
    enable = true,
    disable = {
      'cpp',
      'zig',
      'lua',
      'html',
      'javascript',
    },
  }
}

require 'neodev'.setup {}

-- lsp
local lspconfig = require 'lspconfig'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

lspconfig.lua_ls.setup {
  capabilities = capabilities,
}

lspconfig.racket_langserver.setup {
  capabilities = capabilities,
}

-- snippy
require 'snippy'.setup {
  mappings = {
    is = {
      ['<tab>'] = 'expand_or_advance',
      ['<s-tab>'] = 'previous',
    },
  },
}

-- nvim cmp
local cmp = require 'cmp'
local cmp_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "󰛄",
  Field = "",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "󰆐",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

cmp.setup {
  snippet = {
    expand = function(args)
      require 'snippy'.expand_snippet(args.body)
    end
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, vim_item)
      vim_item.menu = vim_item.kind
      vim_item.kind = cmp_icons[vim_item.kind]
      return vim_item
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<c-b>'] = cmp.mapping.scroll_docs(-4),
    ['<c-f>'] = cmp.mapping.scroll_docs(4),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<c-e>'] = cmp.mapping.abort(),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'snippy' },
  }, {
    { name = 'buffer' },
  }),
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
