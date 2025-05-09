local winbar_filetype_exclude = {
	"qf",
	"prompt",
	"terminal",
	"checkhealth",
	"oil",
	"toggleterm",
	"Trouble",
	"NeogitStatus",
}

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	group = "config",
	callback = function()
		if vim.api.nvim_win_get_config(0).relative ~= "" then
			-- ignore floating window
		elseif vim.tbl_contains(winbar_filetype_exclude, vim.bo.ft) then
			vim.opt_local.winbar = ""
		elseif vim.bo.ft == "oil" then
			vim.opt_local.winbar = [[%#TabLineSel# oil%{&modified ? " " : ""} ]]
				.. [[%#LineNr# %{v:lua.Config.oil_get_path()}]]
		elseif vim.bo.ft == "SymbolsSidebar" then
			vim.opt_local.winbar = [[%#TabLineSel# symbols %#Comment#]]
		else
			-- default
			vim.opt_local.winbar = [[%#TabLineSel# %t%{&modified ? " " : ""} ]]
				.. [[%#LineNr# %{v:lua.Config.buf_get_short_path()}]]
		end
	end,
})
