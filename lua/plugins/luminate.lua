return {
  'doongjohn/luminate.nvim',
  event = 'VeryLazy',
  opts = {
    duration = 180,
    yank = {
      hlgroup = 'DiffText',
    },
    paste = {
      hlgroup = 'DiffAdd',
    },
    undo = {
      hlgroup = 'DiffAdd',
    },
    redo = {
      hlgroup = 'DiffAdd',
    },
  },
}
