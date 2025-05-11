return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	cmd = { "Trouble" },
	keys = {
		{ "<leader>t", "<cmd>Trouble diagnostics focus<cr>" },
	},
	opts = {},
}
