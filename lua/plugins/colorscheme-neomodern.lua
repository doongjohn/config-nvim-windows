return {
	"cdmill/neomodern.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("neomodern").setup({})

		vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
			group = "config",
			callback = function()
				if vim.g.colors_name == "gyokuro" then
					local hl = vim.api.nvim_get_hl(0, { name = "LineNr" })
					vim.api.nvim_set_hl(0, "LineNr", { fg = hl.fg })
					vim.api.nvim_set_hl(0, "WinBar", { link = "Normal" })
					vim.api.nvim_set_hl(0, "WinBarNC", { link = "Normal" })
				end
			end,
		})
	end,
}
