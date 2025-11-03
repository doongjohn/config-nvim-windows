return {
	"shortcuts/no-neck-pain.nvim",
	lazy = false,
	version = "*",
	config = function()
		local nnp = require("no-neck-pain")

		local is_enabled = false
		local vim_cmd_only = false

		nnp.setup({
			width = 130,
			autocmds = {
				enableOnVimEnter = true,
				enableOnTabEnter = true,
			},
			callbacks = {
				preEnable = function()
					if vim.bo.ft == "NeogitStatus" then
						nnp.disable()
					end
				end,
				postEnable = function()
					is_enabled = true
				end,
				postDisable = function()
					is_enabled = false
					if vim_cmd_only then
						vim_cmd_only = false
						vim.schedule(function()
							vim.cmd("only")
							nnp.enable()
						end)
					end
				end,
			},
		})

		local cwo = function()
			if is_enabled then
				vim_cmd_only = true
				nnp.disable()
			else
				vim.cmd("only")
			end
		end

		vim.keymap.set("n", "<c-w>o", cwo, { noremap = true })
		vim.keymap.set("n", "<c-w><c-o>", cwo, { noremap = true })
	end,
	opts = {},
}
