-- filetypes
vim.filetype.add({
	extension = {
		nim = "nim",
		nims = "nims",
		nimble = "nimble",
		xaml = "xml",
		axaml = "xml",
	},
	filename = {
		["nimble.lock"] = "json",
	},
})

-- indent with tab
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = {
		"gitconfig",
		"make",
		"lua",
		"go",
		"odin",
		"gdscript",
	},
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = false
	end,
})

-- indent with spaces
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = {
		"fish",
		"ps1",
		"nu",
		"cs",
		"java",
		"kotlin",
		"zig",
		"python",
		"glsl",
		"markdown",
	},
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = true
	end,
})

-- comment string settings
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = {
		"c",
		"cpp",
		"odin",
	},
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = {
		"nim",
		"nims",
		"nimble",
	},
	callback = function()
		vim.bo.commentstring = "# %s"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = {
		"svelte",
	},
	callback = function()
		vim.bo.commentstring = "<!-- %s -->"
	end,
})

-- zig
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0
