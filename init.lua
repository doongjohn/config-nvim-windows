os.setlocale("en_US.UTF8")

if os.getenv("MSYS") then
	vim.o.shell = "cmd.exe"
	vim.o.shellcmdflag = "/s /c"
end

-- general options
vim.o.exrc = true
vim.o.belloff = "all"
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.wrap = false
vim.o.number = true
vim.o.signcolumn = "yes:1"
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.syntax = "on"
vim.o.sidescrolloff = 10
vim.o.jumpoptions = "stack,view"

-- 2 spaces indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- show whitespace
vim.o.list = true
vim.opt.listchars:append({
	trail = "·",
	tab = "  ",
})

-- split options
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.opt.fillchars:append({
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
	eob = " ",
})

-- diagnostic options
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		},
	},
})

-- leader key
vim.g.maplocalleader = ","

-- config augroup
vim.api.nvim_create_augroup("config", {})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "config",
	callback = function()
		vim.hl.on_yank({ higroup = "DiffText" })
	end,
})

-- enable cursorline for quick fix
vim.api.nvim_create_autocmd("FileType", {
	group = "config",
	pattern = "qf",
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

-- modules
require("globals")
require("filetypes")
require("winbar")
require("keymaps")
require("multiterm")

-- setup lazy nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	ui = {
		backdrop = 100,
	},
	change_detection = {
		notify = false,
	},
	rocks = {
		enabled = false,
	},
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "kanagawa" },
	},
	performance = {
		rtp = {
			reset = true,
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

if vim.g.neovide then
	vim.o.guifont = "Hack Nerd Font,Sarasa Fixed K:h14"
	vim.o.linespace = 7
	vim.g.neovide_title_background_color =
		string.format("%x", vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg)
	vim.g.neovide_floating_shadow = false
	vim.g.neovide_floating_corner_radius = 0.2
	vim.g.neovide_scroll_animation_length = 0
	vim.g.neovide_floating_blur_amount_x = 1.0
	vim.g.neovide_floating_blur_amount_y = 1.0
	vim.g.neovide_cursor_trail_size = 0.3
	vim.g.neovide_cursor_animation_length = 0.04
	vim.g.neovide_cursor_short_animation_length = 0.04
end
