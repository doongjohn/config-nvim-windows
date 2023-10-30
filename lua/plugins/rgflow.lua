return {
  'mangelozzi/rgflow.nvim',
  opts = {
    cmd_flags =
      '--no-heading --smart-case -.ni'
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
      .. ' -g !zig-cache'
      .. ' -g !zig-out',
    default_trigger_mappings = false,
    default_ui_mappings = true,
    default_quickfix_mappings = true,
  }
}
