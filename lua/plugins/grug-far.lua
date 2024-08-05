return {
  'magicduck/grug-far.nvim',
  opts = {
    engines = {
      ripgrep = {
        extraArgs =
            '--no-heading -.ni'
            .. ' -g !.git'
            .. ' -g !.github'
            .. ' -g !*cache'
            .. ' -g !obj'
            .. ' -g !.objs'
            .. ' -g !.deps'
            .. ' -g !lib'
            .. ' -g !libs'
            .. ' -g !bin'
            .. ' -g !out'
            .. ' -g !build'
            .. ' -g !target'
            .. ' -g !vendor'
            .. ' -g !dist'
            .. ' -g !node_modules'
            .. ' -g !zig-out',
      },
    },
    wrap = false,
  },
}
