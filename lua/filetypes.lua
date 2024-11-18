-- options per filetype
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = {
		"oil",
	},
	callback = function()
		vim.opt_local.cursorline = true
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = {
		"toggleterm",
	},
	callback = function()
		vim.opt_local.signcolumn = "no"
	end,
})
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
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = {
		"markdown",
		"fish",
		"nu",
		"python",
		"cs",
		"zig",
		"glsl",
	},
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = {
		"nim",
	},
	callback = function()
		vim.keymap.set("n", "<s-k>", vim.lsp.buf.hover)
	end,
})

-- comment string per filetype
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
