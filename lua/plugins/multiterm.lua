return {
	"imranzero/multiterm.nvim",
	cmd = "Multiterm",
	init = function()
		vim.keymap.set("n", "<leader><c-k>", function()
			require("multiterm.core").list_terminals()
		end)

		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = "config",
			callback = function()
				if #vim.bo.buftype == 0 and vim.api.nvim_win_get_config(0).relative == "" then
					vim.keymap.set("n", "<c-k>", function()
						vim.cmd("1Multiterm nu")
					end, { buffer = true })
				end

				vim.schedule(function()
					local ok, _ = pcall(vim.api.nvim_win_get_var, 0, "_multiterm_term_tag")
					if ok then
						local hl = "NormalFloat:Normal,FloatBorder:WinSeparator"
						vim.api.nvim_set_option_value("winhighlight", hl, { scope = "local", win = 0 })

						vim.keymap.set("n", "<c-k>", function()
							vim.cmd("Multiterm")
						end, { buffer = true })
						vim.keymap.set("t", "<c-k>", function()
							vim.cmd("Multiterm")
						end, { buffer = true })
					end
					if vim.bo.buftype == "terminal" then
						vim.cmd("startinsert")
					end
				end)
			end,
		})
	end,
	opts = {
		height = 0.7,
		width = 0.7,
		border = "single",
		border_hl = "WinSeparator",
	},
}
