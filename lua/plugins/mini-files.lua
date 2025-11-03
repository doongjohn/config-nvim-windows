return {
	"nvim-mini/mini.files",
	version = "*",
	keys = {
		{
			"<leader>e",
			function()
				MiniFiles.open()
			end,
		},
	},
	---@module 'mini.files'
	---@MiniFiles.config
	opts = {
		options = {
			permanent_delete = false,
			use_as_default_explorer = false,
		},
	},
}
