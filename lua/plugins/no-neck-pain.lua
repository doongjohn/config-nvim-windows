return {
	"shortcuts/no-neck-pain.nvim",
	lazy = false,
	version = "*",
	init = function()
		local nnp = require("no-neck-pain")
		vim.keymap.set("n", "<c-w>o", function()
			if nnp.state then
				nnp.disable()
				vim.fn.wait(5000, function()
					return nnp.state == nil
				end)
				vim.cmd("only")
				nnp.enable()
			else
				vim.cmd("only")
			end
		end)
	end,
	opts = {
		width = 120,
		autocmds = {
			enableOnVimEnter = true,
			enableOnTabEnter = true,
		},
	},
}
