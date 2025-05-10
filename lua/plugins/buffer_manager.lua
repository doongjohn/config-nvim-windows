return {
	-- buffer manager
	"j-morano/buffer_manager.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader><space>",
			function()
				require("buffer_manager.ui").toggle_quick_menu()
			end,
		},
	},
	opts = {
		highlight = "Normal:FloatTitle",
		borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
		show_indicators = "before",
		select_menu_item_commands = {
			s = {
				key = "<c-s>",
				command = "split",
			},
			v = {
				key = "<c-v>",
				command = "vsplit",
			},
		},
		format_function = function(input)
			local cwd = vim.fs.normalize(vim.fn.getcwd()) .. "/"
			local path = vim.fs.normalize(input)
			if vim.startswith(path, cwd) then
				path = path:gsub(cwd, "", 1)
			end
			return path
		end,
	},
}
