return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	config = function()
		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
			local fg = 0
			if hl.bg then
				if vim.o.background == "dark" then
					fg = Config.color.adjust_brightness(hl.bg, 1.8)
				else
					fg = Config.color.adjust_brightness(hl.bg, 0.85)
				end
				vim.api.nvim_set_hl(0, "IblIndent", { fg = fg })
			else
				vim.api.nvim_set_hl(0, "IblIndent", { link = "LineNr" })
			end
		end)

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
