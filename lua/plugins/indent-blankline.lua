return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	config = function()
		vim.api.nvim_set_hl(0, "IblIndent", { link = "LineNr" })

		require("ibl").setup({
			indent = {
				highlight = "IblIndent",
				char = "│",
				tab_char = "│",
			},
			scope = {
				enabled = false,
			},
		})
	end,
}
