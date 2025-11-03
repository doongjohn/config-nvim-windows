return {
	"ggandor/leap.nvim",
	lazy = false,
	config = function()
		local leap = require("leap")

		leap.opts.highlight_unlabeled_phase_one_targets = true
		leap.opts.safe_labels = {}
		leap.opts.vim_opts = {
			["go.ignorecase"] = true,
		}

		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

		vim.keymap.set("n", "m", "<Plug>(leap-anywhere)")
		vim.keymap.set("v", "m", "<Plug>(leap)")
		vim.keymap.set("o", "m", "<Plug>(leap)")
	end,
}
