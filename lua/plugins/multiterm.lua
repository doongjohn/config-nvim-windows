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
				vim.schedule(function()
					local ok, _ = pcall(vim.api.nvim_win_get_var, 0, "_multiterm_term_tag")
					if ok then
						vim.keymap.set("t", "<c-k>", function()
							vim.cmd("Multiterm")
						end, { buffer = true })
					end
					if vim.bo.buftype == "terminal" then
						vim.cmd("startinsert")
					end
				end)

				if #vim.bo.buftype == 0 and vim.api.nvim_win_get_config(0).relative == "" then
					vim.keymap.set("n", "<c-k>", function()
						vim.cmd("1Multiterm nu")
					end, { buffer = true })
				end
			end,
		})
	end,
	opts = {
		border = "none",
		backdrop_transparency = 60,
	},
}
