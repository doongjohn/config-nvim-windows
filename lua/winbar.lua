local winbar_filetype_exclude = {
	"qf",
	"prompt",
	"terminal",
	"checkhealth",
	"NvimTree",
	"trouble",
	"toggleterm",
	"NeogitStatus",
}

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
	group = "config",
	callback = function()
		local is_floating_win = vim.api.nvim_win_get_config(0).relative ~= ""
		local is_exclude_ft = vim.tbl_contains(winbar_filetype_exclude, vim.bo.ft)
		if is_floating_win or is_exclude_ft then
			return
		end

		local opts_win = { scope = "local", win = 0 }

		if vim.bo.ft == "oil" then
			local winbar = ""
				.. [[%{&modified ? "" : " "} ]]
				.. [[%#TabLineSel# oil ]]
				.. [[%#LineNr# %{v:lua.Config.oil_get_path()}]]
			vim.api.nvim_set_option_value("winbar", winbar, opts_win)
			return
		end

		if vim.bo.ft == "Fyler" then
			local winbar = ""
				.. [[%{&modified ? "" : " "} ]]
				.. [[%#TabLineSel# files ]]
				.. [[%#LineNr# %{v:lua.Config.fyler_get_path()}]]
			vim.api.nvim_set_option_value("winbar", winbar, opts_win)
			return
		end

		if vim.bo.ft == "SymbolsSidebar" then
			local winbar = [[%#TabLineSel# symbols %#Comment#]]
			vim.api.nvim_set_option_value("winbar", winbar, opts_win)
			return
		end

		-- default
		local winbar = ""
			.. [[%{&modified ? "" : " "} ]]
			.. [[%#TabLineSel# %t ]]
			.. [[%#LineNr# %{v:lua.Config.buf_get_short_path()}]]
		vim.api.nvim_set_option_value("winbar", winbar, opts_win)
	end,
})
