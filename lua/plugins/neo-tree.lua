return {
	-- file tree
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"muniftanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	keys = {
		{ "<leader>e", "<cmd>Neotree current<cr>" },
		{ "<leader>E", "<cmd>Neotree current reveal=true<cr>" },
	},
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		close_if_last_window = true,
		default_component_configs = {
			icon = {
				default = "",
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				folder_empty_open = "",
			},
			git_status = {
				symbols = {
					added = "",
					modified = "",
					deleted = "",
					renamed = "",
					untracked = "?",
					ignored = "󰔌",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
		},
		window = {
			mappings = {
				["h"] = function(state)
					local node = state.tree:get_node()
					if (node.type == "directory" or node:has_children()) and node:is_expanded() then
						state.commands.toggle_node(state)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				["l"] = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" or node:has_children() then
						if not node:is_expanded() then
							state.commands.toggle_node(state)
						else
							require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
						end
					end
				end,
			},
		},
		filesystem = {
			use_libuv_file_watcher = true,
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
			},
		},
	},
}
