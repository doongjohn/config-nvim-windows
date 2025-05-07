return {
	-- code action menu with preview
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
	},
	event = "LspAttach",
	keys = {
		{
			"<a-o>",
			function()
				require("tiny-code-action").code_action({})
			end,
		},
	},
	opts = {
		picker = "snacks",
	},
}
