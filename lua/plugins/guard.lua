return {
	"nvimdev/guard.nvim",
	dependencies = {
		"nvimdev/guard-collection",
	},
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		vim.g.guard_config = {
			fmt_on_save = false,
			lsp_as_default_formatter = true,
			save_on_fmt = true,
		}

		local ft = require("guard.filetype")
		local lsp = require("guard.lsp")

		ft("lua"):fmt("stylua")

		ft("markdown,json,html,css,javascript,typescript,svelte"):fmt(function()
			if vim.uv.fs_stat(".prettierrc") then
				return {
					cmd = "pnpm",
					args = { "exec", "prettier", "--stdin-filepath" },
					fname = true,
					stdin = true,
				}
			else
				return {
					fn = lsp.format,
				}
			end
		end)
	end,
}
