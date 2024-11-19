return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	event = "UIEnter",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		-- Add or skip cursor above/below the main cursor.
		vim.keymap.set({ "n", "v" }, "<up>", function()
			mc.lineAddCursor(-1)
		end)
		vim.keymap.set({ "n", "v" }, "<down>", function()
			mc.lineAddCursor(1)
		end)
		vim.keymap.set({ "n", "v" }, "<leader><up>", function()
			mc.lineSkipCursor(-1)
		end)
		vim.keymap.set({ "n", "v" }, "<leader><down>", function()
			mc.lineSkipCursor(1)
		end)

		-- Add or skip adding a new cursor by matching word/selection
		vim.keymap.set({ "n", "v" }, "<leader>n", function()
			mc.matchAddCursor(1)
		end)
		vim.keymap.set({ "n", "v" }, "<leader>s", function()
			mc.matchSkipCursor(1)
		end)
		vim.keymap.set({ "n", "v" }, "<leader>N", function()
			mc.matchAddCursor(-1)
		end)
		vim.keymap.set({ "n", "v" }, "<leader>S", function()
			mc.matchSkipCursor(-1)
		end)

		-- Rotate the main cursor.
		vim.keymap.set({ "n", "v" }, "<right>", mc.nextCursor)
		vim.keymap.set({ "n", "v" }, "<left>", mc.prevCursor)

		-- Delete the main cursor.
		vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor)

		-- Add and remove cursors with control + left click.
		vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

		-- Easy way to add and remove cursors using the main cursor.
		vim.keymap.set({ "n", "v" }, "<c-q>", mc.toggleCursor)

		-- Clone every cursor and disable the originals.
		vim.keymap.set({ "n", "v" }, "<leader><c-q>", mc.duplicateCursors)

		vim.keymap.set("n", "<esc>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			else
				-- Default <esc> handler.
			end
		end)

		-- bring back cursors if you accidentally clear them
		vim.keymap.set("n", "<leader>gv", mc.restoreCursors)

		-- Rotate visual selection contents.
		vim.keymap.set("v", "<leader>t", function()
			mc.transposeCursors(1)
		end)
		vim.keymap.set("v", "<leader>T", function()
			mc.transposeCursors(-1)
		end)

		-- Jumplist support
		vim.keymap.set({ "v", "n" }, "<c-i>", mc.jumpForward)
		vim.keymap.set({ "v", "n" }, "<c-o>", mc.jumpBackward)

		-- Customize how cursors look.
		vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "@comment.warning" })
	end,
}
