return {
  'nathom/filetype.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    require 'filetype'.setup {
      overrides = {
        extensions = {
          sh = 'sh',
          bash = 'bash',
          c = 'c',
          cc = 'cpp',
          h = 'cpp', -- this is unfortunate
          nim = 'nim',
          nims = 'nims',
          nimble = 'nimble',
          cr = 'crystal',
          rkt = 'racket',
          make = 'make',
          hpp = 'cpp',
          asm = 'nasm',
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

    vim.api.nvim_create_augroup('FtInit', {})

    vim.api.nvim_create_autocmd('FileType', {
      group = 'FtInit',
      pattern = { 'gitconfig', 'markdown', 'fish', 'python', 'go', 'zig', 'odin' },
      callback = function()
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
      end
    })
    vim.api.nvim_create_autocmd('FileType', {
      group = 'FtInit',
      pattern = { 'gitconfig', 'make', 'odin' },
      callback = function()
        vim.bo.expandtab = false
      end
    })
    vim.api.nvim_create_autocmd('FileType', {
      group = 'FtInit',
      pattern = { 'oil' },
      callback = function()
        vim.opt_local.cursorline = true
      end
    })

    vim.api.nvim_create_autocmd('BufEnter', {
      group = 'FtInit',
      pattern = { '*.nims', '*.nimble' },
      callback = function()
        vim.opt.syntax = 'nim'
      end
    })
    vim.api.nvim_create_autocmd('BufEnter', {
      group = 'FtInit',
      pattern = { '*.vifm', 'vifmrc' },
      callback = function()
        vim.opt.syntax = 'vim'
      end
    })

    -- setup winbar
    local winbar_filetype_exclude = {
      'qf',
      'prompt',
      'terminal',
      'lazy',
      'oil',
      'neo-tree',
      'neo-tree-popup',
      'toggleterm',
      'fzf',
      'Telescope',
      'TelescopePrompt',
      'TelescopeResults',
      'Trouble',
    }
    vim.api.nvim_create_autocmd('FileType', {
      group = 'FtInit',
      pattern = { '*' },
      callback = function()
        if not vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
          vim.opt_local.winbar =
            [[%#TabLineSel# %t%{&modified ? " *" : ""} ]] ..
            [[%#Comment# %{%v:lua.require'nvim-navic'.get_location()%}]]
        end
      end
    })
  end
}
