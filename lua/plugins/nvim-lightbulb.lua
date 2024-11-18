return {
	"kosayoda/nvim-lightbulb",
	event = "LspAttach",
	opts = {
		sign = { enabled = false },
		float = {
			enabled = true,
			hl = "StatusLine",
		},
		autocmd = { enabled = true },
		ignore = {
			clients = {
				"lua_ls",
				"ts_ls",
				"gopls",
				"zls",
			},
		},
	},
}
