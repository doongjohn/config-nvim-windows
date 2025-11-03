return {
	"shortcuts/no-neck-pain.nvim",
	lazy = false,
	version = "*",
	opts = {
		width = 130,
		fallbackOnBufferDelete = false,
		autocmds = {
			enableOnVimEnter = true,
			skipEnteringNoNeckPainBuffer = true,
		},
	},
}
