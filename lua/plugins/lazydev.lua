return {
	"folke/lazydev.nvim",
	ft = "lua",
	config = function()
		local lazydev = require("lazydev")
		local luals_dir = vim.fs.dirname(vim.fs.dirname(vim.fn.exepath("lua-language-server")))

		---@diagnostic disable: missing-fields
		lazydev.setup({
			library = {
				vim.fs.joinpath(luals_dir, "meta/template"),
				{
					path = vim.fs.joinpath(luals_dir, "meta/3rd/luv/library"),
					words = {
						"vim%.uv",
						"vim%.schedule",
						"vim%.defer_fn",
					},
				},
			},
		})
		---@diagnostic enable: missing-fields
	end,
}
