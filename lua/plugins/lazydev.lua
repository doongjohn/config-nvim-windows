return {
	"folke/lazydev.nvim",
	ft = "lua",
	config = function()
		local lazydev = require("lazydev")
		local luals_dir = vim.fs.dirname(vim.fs.dirname(vim.fn.exepath("lua-language-server")))

		lazydev.setup({
			library = {
				vim.fs.joinpath(luals_dir, "meta/LuaJIT en-us utf8"),
				vim.fs.joinpath(luals_dir, "meta/3rd/luv/library"),
			},
		})
	end,
}
