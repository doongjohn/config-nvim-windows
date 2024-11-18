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

		ft("lua"):fmt("stylua")

		ft("json,html,css,javascript,typescript,svelte"):fmt(function()
			if vim.uv.fs_stat(".prettierrc") then
				return {
					cmd = "pnpm",
					args = { "exec", "prettier", "--stdin-filepath" },
					fname = true,
					stdin = true,
				}
			end
		end)
	end,
}
