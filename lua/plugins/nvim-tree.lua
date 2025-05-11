return {
	"nvim-tree/nvim-tree.lua",
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>" },
		{ "<leader>E", "<cmd>NvimTreeFindFile<cr>" },
	},
	config = function()
		require("nvim-tree").setup({
			renderer = {
				icons = {
					glyphs = {
						git = {
							unstaged = "",
							staged = "󰸩",
							unmerged = "",
							renamed = "",
							untracked = "?",
							deleted = "",
							ignored = "󰔌",
						},
					},
				},
			},
			filters = {
				git_ignored = false,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				local cd_to_current_node = function()
					---@type Node|FileNode|DirectoryNode
					local node = api.tree.get_node_under_cursor()
					if node.name == ".." then
						return
					end
					api.tree.change_root_to_node(node)
					vim.cmd("norm gg0")
				end

				local dir_open = function()
					---@type Node|FileNode|DirectoryNode
					local node = api.tree.get_node_under_cursor()
					if node.name == ".." then
						return
					end
					if node.type == "directory" then
						api.node.open.edit()
					end
				end

				local goto_parent_or_collapse = function()
					---@type Node|FileNode|DirectoryNode
					local node = api.tree.get_node_under_cursor()
					if node.name == ".." then
						return
					end
					if node.type == "file" or (node.type == "directory" and not node.open) then
						api.node.navigate.parent()
					elseif node.type == "directory" and node.open then
						api.node.open.edit()
					end
				end

				vim.keymap.del("n", "E", opts(""))
				vim.keymap.del("n", "<c-]>", opts(""))

				vim.keymap.set("n", "`", cd_to_current_node, opts("CD"))
				vim.keymap.set("n", "l", dir_open, opts("Open dir"))
				vim.keymap.set("n", "h", goto_parent_or_collapse, opts("Go to parent dir or collapse dir"))
			end,
		})

		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = "config",
			pattern = "NvimTree*",
			callback = function()
				vim.wo.scrolloff = 3
			end,
		})
	end,
}
