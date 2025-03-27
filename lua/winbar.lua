local winbar_filetype_exclude = {
	"qf",
	"prompt",
	"terminal",
	"checkhealth",
	"oil",
	"neo-tree",
	"toggleterm",
	"Outline",
	"Trouble",
	"NeogitStatus",
}

vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	callback = function()
		if vim.api.nvim_win_get_config(0).relative ~= "" then
			-- ignore floating window
			return
		elseif vim.startswith(vim.api.nvim_buf_get_name(0), "oil") then
			vim.opt_local.winbar = [[%#TabLineSel# oil%{&modified ? " *" : ""} %#Comment# %{%luaeval("vim.api.nvim_buf_get_name(0):sub(7,-1)")%}]]
		elseif not vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
			vim.opt_local.winbar = [[%#TabLineSel# %t%{&modified ? " *" : ""} %#Comment#]]
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = "config",
	callback = function()
		if vim.bo.filetype == "Outline" then
			vim.opt_local.winbar = [[%#TabLineSel# outline %#Comment#]]
		end
	end,
})
