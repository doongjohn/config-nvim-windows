return {
	"akinsho/toggleterm.nvim",
	cmd = { "ToggleTerm", "TermExec" },
	opts = {
		shell = "nu",
		shade_terminals = false,
	},
	init = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = "config",
			callback = function()
				if #vim.bo.buftype ~= 0 or vim.api.nvim_win_get_config(0).relative ~= "" then
					return
				end

				local function toggleTerm()
					vim.cmd("ToggleTerm direction=horizontal")
				end

				vim.keymap.set("n", "<c-k>", toggleTerm, { buffer = true })
				vim.keymap.set("t", "<c-k>", toggleTerm, { buffer = true })
			end,
		})
	end,
}
