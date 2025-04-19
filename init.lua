os.setlocale("en_US.UTF8")

-- general options
vim.o.exrc = true
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

if os.getenv("MSYS") then
	vim.o.shell = "cmd.exe"
	vim.o.shellcmdflag = "/s /c"
end

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

-- show whitespace
vim.o.list = true
vim.opt.listchars:append({
	trail = "·",
	tab = "  ",
})

-- use 2 spaces for indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- leader key
vim.g.maplocalleader = ","

-- filetypes
vim.filetype.add({
	extension = {
		make = "make",
		asm = "nasm",
		h = "cpp", -- this is unfortunate
		hpp = "cpp",
		d = "d",
		nim = "nim",
		nims = "nims",
		nimble = "nimble",
		cr = "crystal",
		asd = "lisp",
	},
	filename = {
		["go.mod"] = "gomod",
		["go.sum"] = "gosum",
		["nimble.lock"] = "json",
	},
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

-- augroup
vim.api.nvim_create_augroup("config", {})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "config",
	callback = function()
		vim.hl.on_yank({ higroup = "DiffText" })
	end,
})

-- modules
require("filetypes")
require("winbar")

-- keymaps
do
	-- disable right click menu
	vim.keymap.set("n", "<rightmouse>", "<nop>")
	vim.keymap.set("i", "<rightmouse>", "<nop>")

	-- esc
	vim.keymap.set("v", "<c-l>", "<esc>")
	vim.keymap.set("i", "<c-l>", "<esc>")

	-- inner line
	vim.keymap.set("v", "il", ":<c-u>norm ^vg_<cr>", { desc = "inner line" })
	vim.keymap.set("o", "il", "<cmd>norm ^vg_<cr>", { desc = "inner line" })

	-- highlight word under cursor
	vim.keymap.set("n", "<leader>h", function()
		local view = vim.fn.winsaveview()
		vim.cmd("norm *")
		vim.fn.winrestview(view)
	end, { silent = true, desc = "highlight word under cursor" })

	-- highlight selected
	vim.keymap.set("v", "<leader>h", function()
		local view = vim.fn.winsaveview()
		vim.cmd(vim.api.nvim_replace_termcodes([[norm ""y/<c-r>"<cr>]], true, false, true))
		vim.fn.winrestview(view)
	end, { silent = true, desc = "highlight selected text" })

	-- paste yanked text
	vim.keymap.set("n", "<leader>p", '"0p', { silent = true })
	vim.keymap.set("v", "<leader>p", '"0p', { silent = true })

	-- indent using tab
	vim.keymap.set("v", "<tab>", ">gv", { silent = true })
	vim.keymap.set("v", "<s-tab>", "<gv", { silent = true })

	-- move text up down
	vim.keymap.set("n", "<a-j>", "v:move '>+1<cr>", { silent = true })
	vim.keymap.set("n", "<a-k>", "v:move '<-2<cr>", { silent = true })
	vim.keymap.set("v", "<a-j>", ":move '>+1<cr>gv-gv", { silent = true })
	vim.keymap.set("v", "<a-k>", ":move '<-2<cr>gv-gv", { silent = true })

	-- lsp
	vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, { silent = true })

	-- utils
	vim.keymap.set(
		"v",
		"<leader>,",
		[[:s/\%V./'&', /g<cr>:noh<cr>]],
		{ silent = true, desc = "convert selected text to char array" }
	)
end

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

-- neovide
if vim.g.neovide then
	vim.g.neovide_fullscreen = true
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_padding_right = 5
	vim.g.neovide_padding_left = 5

	vim.o.guifont = "Hack Nerd Font,Sarasa Fixed K:h14"
	vim.o.linespace = 9

	vim.g.neovide_scroll_animation_length = 0.2
	vim.g.neovide_cursor_animation_length = 0.12

	vim.g.neovide_floating_shadow = false
	vim.g.neovide_floating_blur_amount_x = 1.0
	vim.g.neovide_floating_blur_amount_y = 1.0

	local hl_normal = vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") })
	vim.g.neovide_title_background_color = string.format("%x", hl_normal.bg)
	vim.g.neovide_title_text_color = string.format("%x", hl_normal.fg)
end
