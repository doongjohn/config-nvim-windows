return {
  'magicduck/grug-far.nvim',
  opts = {
    extraRgArgs =
      '--no-heading -.ni'
      .. ' -g !.objs'
      .. ' -g !.deps'
      .. ' -g !.cache'
      .. ' -g !.git'
      .. ' -g !.github'
      .. ' -g !cache'
      .. ' -g !vendor'
      .. ' -g !dep'
      .. ' -g !deps'
      .. ' -g !lib'
      .. ' -g !libs'
      .. ' -g !out'
      .. ' -g !build'
      .. ' -g !build_*'
      .. ' -g !target'
      .. ' -g !dist'
      .. ' -g !node_modules'
      .. ' -g !.zig-cache'
      .. ' -g !zig-out',
  },
}
