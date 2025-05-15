return {
	"shatur/neovim-session-manager",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	lazy = false,
	config = function()
		local config = require("session_manager.config")
		require("session_manager").setup({
			autoload_mode = config.AutoloadMode.CurrentDir,
			autosave_last_session = true,
			autosave_ignore_not_normal = true,
			autosave_ignore_buftypes = {
				"qf",
				"prompt",
				"terminal",
				"checkhealth",
				"oil",
				"grug-far",
				"trouble",
				"toggleterm",
				"NeogitStatus",
			},
			autosave_only_in_session = true,
			max_path_length = 0,
		})
	end,
}
