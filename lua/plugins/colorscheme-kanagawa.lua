return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("kanagawa").setup({
			commentStyle = { bold = false, italic = false },
			keywordStyle = { bold = false, italic = false },
			statementStyle = { bold = false, italic = false },
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},

			---@param colors KanagawaColors
			overrides = function(colors)
				local theme = colors.theme
				local palette = colors.palette

				return {
					WinSeparator = { fg = theme.ui.bg_p1 },
					FloatBorder = { bg = theme.ui.float.bg, fg = theme.ui.float.bg },

					Pmenu = { bg = theme.ui.bg_p1 },
					PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },

					-- treesitter
					["@module"] = { link = "@keyword.import" },
					["@field"] = { link = "@variable.member" },
					["@variable.parameter"] = { fg = palette.oldWhite },
				}
			end,
		})
	end,
}
