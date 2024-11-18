return {
	-- code action menu with preview
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	event = "LspAttach",
	keys = {
		{
			"<leader>'",
			function()
				require("tiny-code-action").code_action()
			end,
		},
	},
	opts = {},
}
