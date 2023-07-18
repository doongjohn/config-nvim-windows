return {
  -- file tree
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'muniftanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>e', '<cmd>Neotree show current<cr>' },
    { '<leader>E', '<cmd>Neotree show current reveal=true<cr>' },
  },
  opts = {
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
  },
}
