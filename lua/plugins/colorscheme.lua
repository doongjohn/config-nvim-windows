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

					-- Snacks
					SnacksPickerIdx = { link = "LineNr" },
				}
			end,
		})

		vim.o.background = "dark"
		vim.cmd("colorscheme kanagawa-wave")

		-- semantic highlighting: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
		vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "@variable" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.method.readonly.cpp", { link = "@function.method" })
		vim.api.nvim_set_hl(0, "@lsp.type.builtin.zig", { link = "@type.builtin" })
		vim.api.nvim_set_hl(0, "@lsp.type.keywordLiteral.zig", { link = "@keyword" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.variable.static.zig", { link = "@variable" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.namespace.readonly.odin", { link = "@module" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.type.readonly.odin", { link = "@type" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.enum.readonly.odin", { link = "@type" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.struct.readonly.odin", { link = "@type" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.method.readonly.typescript", { link = "@function.method" })

		-- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316?permalink_comment_id=4534819#dealing-with-ambiguity
		vim.api.nvim_create_autocmd("LspTokenUpdate", {
			group = "config",
			callback = function(args)
				local token = args.data.token

				if token.type == "method" then
					if token.modifiers.defaultLibrary then
						vim.lsp.semantic_tokens.highlight_token(
							token,
							args.buf,
							args.data.client_id,
							"@lsp.typemod.method.defaultLibrary"
						)
					end
				end
			end,
		})
	end,
}
