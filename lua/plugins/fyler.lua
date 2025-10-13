return {
	"A7Lavinraj/fyler.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>e", "<cmd>Fyler kind=split_left_most<cr>" },
		{
			"<leader>E",
			function()
				local fyler = require("fyler")
				fyler.track_buffer()
				fyler.open()
			end,
		},
	},
	opts = {
		icon = {
			directory_collapsed = nil,
			directory_empty = "",
			directory_expanded = nil,
		},
		icon_provider = "nvim_web_devicons",
		track_current_buffer = false,
		mappings = {
			["q"] = "CloseView",
			["<cr>"] = "Select",
			["<c-t>"] = "SelectTab",
			["<c-v>"] = "SelectVSplit",
			["<c-s>"] = "SelectSplit",
			["-"] = "GotoParent",
			["_"] = "GotoCwd",
			["."] = "GotoNode",
			["zM"] = "CollapseAll",
			["<bs>"] = "CollapseNode",
		},
		win = {
			win_opts = {
				concealcursor = "nvic",
				conceallevel = 3,
				cursorline = true,
				number = true,
				relativenumber = false,
				wrap = false,
			},
		},
	},
}
