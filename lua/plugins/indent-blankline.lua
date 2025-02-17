return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	init = function()
		vim.api.nvim_set_hl(0, "IblIndent", { link = "LineNr" })
	end,
	opts = {
		indent = {
			highlight = "IblIndent",
			char = "│",
			tab_char = "│",
		},
		scope = {
			enabled = false,
		},
	},
}
