return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	event = "UIEnter",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		-- Add or skip cursor above/below the main cursor.
		vim.keymap.set({ "n", "x" }, "<up>", function()
			mc.lineAddCursor(-1)
		end)
		vim.keymap.set({ "n", "x" }, "<down>", function()
			mc.lineAddCursor(1)
		end)
		vim.keymap.set({ "n", "x" }, "<leader><up>", function()
			mc.lineSkipCursor(-1)
		end)
		vim.keymap.set({ "n", "x" }, "<leader><down>", function()
			mc.lineSkipCursor(1)
		end)

		-- Add or skip adding a new cursor by matching word/selection
		vim.keymap.set({ "n", "x" }, "<leader>n", function()
			mc.matchAddCursor(1)
		end)
		vim.keymap.set({ "n", "x" }, "<leader>s", function()
			mc.matchSkipCursor(1)
		end)
		vim.keymap.set({ "n", "x" }, "<leader>N", function()
			mc.matchAddCursor(-1)
		end)
		vim.keymap.set({ "n", "x" }, "<leader>S", function()
			mc.matchSkipCursor(-1)
		end)

		-- Add and remove cursors with control + left click.
		vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
		vim.keymap.set("n", "<c-leftdrag>", mc.handleMouseDrag)
		vim.keymap.set("n", "<c-leftrelease>", mc.handleMouseRelease)

		-- Select a different cursor as the main one.
		vim.keymap.set({ "n", "x" }, "<left>", mc.nextCursor)
		vim.keymap.set({ "n", "x" }, "<right>", mc.prevCursor)

		-- Delete the main cursor.
		vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor)

		-- Disable and enable cursors.
		vim.keymap.set({ "n", "x" }, "<c-q>", mc.toggleCursor)

		-- Enable and clear cursors using escape.
		vim.keymap.set("n", "<esc>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			else
				-- Default <esc> handler.
			end
		end)

		-- Bring back cursors if you accidentally clear them.
		vim.keymap.set("n", "<leader>gv", mc.restoreCursors)

		-- Customize how cursors look.
		vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "@comment.warning" })
	end,
}
