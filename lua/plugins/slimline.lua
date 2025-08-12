return {
	"sschleemilch/slimline.nvim",
	event = "UIEnter",
	config = function()
		local linecol = function()
			local h = require("slimline.highlights")
			local c = require("slimline").config

			local text = ""
			local line = vim.fn.line(".")
			local ccol = vim.fn.charcol(".")
			local col = vim.fn.col(".")
			if ccol == col then
				text = string.format("%3d:%-2d", line, ccol)
			else
				text = string.format("%3d:%d[%d]", line, ccol, col)
			end

			return h.hl_component({ primary = text }, {
				primary = {
					text = "SlimlineModeSecondary",
					sep = "SlimlineModeSecondarySep",
					sep2sec = "SlimlineModeNormalSep2Sec",
				},
				secondary = {
					text = "SlimlineModeSecondary",
					sep = "SlimlineModeSecondarySep",
				},
			}, c.sep, "left", true, "fg")
		end

		local filetype_lsp = function()
			local h = require("slimline.highlights")
			local c = require("slimline").config

			local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
			local secondary = ""
			if #attached_clients == 0 then
				secondary = ""
			else
				secondary = "(" .. #attached_clients .. " lsp)"
			end

			return h.hl_component({ primary = vim.bo.ft, secondary = secondary }, {
				primary = {
					text = "SlimlineModeSecondary",
					sep = "SlimlineModeSecondarySep",
					sep2sec = "SlimlineModeNormalSep2Sec",
				},
				secondary = {
					text = "SlimlineModeSecondary",
					sep = "SlimlineModeSecondarySep",
				},
			}, c.sep, "left", true, "fg")
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
					directory = false,
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
					filetype_lsp,
					"progress",
				},
			},
		})
	end,
}
