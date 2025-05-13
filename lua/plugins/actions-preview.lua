return {
	"aznhe21/actions-preview.nvim",
	event = "LspAttach",
	keys = {
		{
			"<a-o>",
			function()
				require("actions-preview").code_actions()
			end,
		},
	},
}
