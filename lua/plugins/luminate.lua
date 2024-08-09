return {
  'mei28/luminate.nvim',
  event = 'VeryLazy',
  opts = {
    duration = 200,
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
