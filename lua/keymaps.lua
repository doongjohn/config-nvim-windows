-- disable right click menu
vim.keymap.set("n", "<rightmouse>", "<nop>")
vim.keymap.set("i", "<rightmouse>", "<nop>")

-- map esc to c-l
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

-- indent selected
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
