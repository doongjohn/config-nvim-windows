return {
  -- multi cursor
  'mg979/vim-visual-multi',
  event = 'BufEnter',
  branch = 'master',
  init = function()
    vim.g.VM_theme = 'codedark'
    vim.g.VM_leader = '\\'
    -- vim.g.VM_maps = {}
  end
}
