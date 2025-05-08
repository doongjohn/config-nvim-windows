return {
	"sschleemilch/slimline.nvim",
	event = "UIEnter",
	config = function()
		local linecol = function()
			local h = require("slimline.highlights")
			local c = require("slimline").config

			local secondary = ""
			local line = vim.fn.line(".")
			local ccol = vim.fn.charcol(".")
			local col = vim.fn.col(".")
			if ccol == col then
				secondary = string.format("%3d:%-2d", line, ccol)
			else
				secondary = string.format("%3d:%d[%d]", line, ccol, col)
			end

			return h.hl_component({ primary = "", secondary = secondary }, {
				primary = {
					text = "SlimlineModeNormal",
					sep = "SlimlineModeNormalSep",
					sep2sec = "SlimlineModeNormalSep2Sec",
				},
				secondary = {
					text = "SlimlineModeSecondary",
					sep = "SlimlineModeSecondarySep",
				},
			}, c.sep)
		end

		local diagnostic_signs = vim.diagnostic.config().signs.text
		if not diagnostic_signs then
			diagnostic_signs = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			}
		end

		require("slimline").setup({
			style = "fg",
			sep = {
				left = "",
				right = "",
			},
			hl = {
				base = "TabLineSel",
				secondary = "LineNr",
			},
			configs = {
				mode = {
					hl = {
						normal = "Delimiter",
						insert = "Delimiter",
						pending = "Delimiter",
						visual = "Delimiter",
						command = "Delimiter",
					},
				},
				path = {
					hl = {
						primary = "TabLineSel",
					},
					icons = {
						folder = "",
						modified = "",
						read_only = "",
					},
				},
				git = {
					hl = {
						primary = "Delimiter",
					},
				},
				diagnostics = {
					workspace = false,
					icons = {
						ERROR = diagnostic_signs[vim.diagnostic.severity.ERROR],
						WARN = diagnostic_signs[vim.diagnostic.severity.WARN],
						INFO = diagnostic_signs[vim.diagnostic.severity.INFO],
						HINT = diagnostic_signs[vim.diagnostic.severity.HINT],
					},
				},
				filetype_lsp = {
					hl = {
						primary = "TabLineSel",
					},
				},
			},
			components = {
				left = {
					"mode",
					"path",
					"git",
					"diagnostics",
				},
				center = {},
				right = {
					linecol,
					"filetype_lsp",
					"progress",
				},
			},
		})
	end,
}
