return {
	"A7Lavinraj/fyler.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>e",
			function()
				local fyler = require("fyler")
				fyler.toggle()
			end,
		},
		{
			"<leader>E",
			function()
				local fyler = require("fyler")
				fyler.track_buffer()
				fyler.open()
			end,
		},
	},
	config = function()
		local fyler = require("fyler")

		fyler.setup({
			close_on_select = false,
			icon = {
				directory_collapsed = nil,
				directory_empty = "",
				directory_expanded = nil,
			},
			icon_provider = "nvim_web_devicons",
			mappings = {
				-- TODO: disable default mappings.
				["q"] = "CloseView",
				["<cr>"] = "Select",
				["<c-t>"] = "SelectTab",
				["<c-v>"] = "SelectVSplit",
				["<c-s>"] = "SelectSplit",
				["-"] = "GotoParent",
				-- ["_"] = "GotoCwd",
				["."] = "GotoNode",
				["zM"] = "CollapseAll",
				["<bs>"] = "CollapseNode",
			},
			track_current_buffer = false,
			win = {
				kind = "split_left_most",
				win_opts = {
					concealcursor = "nvic",
					conceallevel = 3,
					cursorline = true,
					number = true,
					relativenumber = false,
					wrap = false,
					scrolloff = 4,
				},
			},
		})

		local is_focused = function(explorer)
			return explorer.win.winid == vim.api.nvim_get_current_win()
		end

		-- Go to vim cwd.
		vim.keymap.set("n", "_", function()
			local explorer = fyler.current()
			if not explorer or not is_focused(explorer) then
				return
			end
			local cwd = explorer:getcwd()
			if cwd then
				explorer.dir = vim.fn.getcwd()
				explorer:chdir(explorer.dir)
				explorer:dispatch_refresh()
			end
		end)

		-- Set vim cwd to fyler cwd.
		vim.keymap.set("n", "`", function()
			local explorer = fyler.current()
			if not explorer or not is_focused(explorer) then
				return
			end
			local cwd = explorer:getcwd()
			if cwd then
				explorer.dir = cwd
				vim.api.nvim_set_current_dir(cwd)
				vim.notify("CWD: " .. cwd, vim.log.levels.INFO)
			end
		end)
	end,
}
