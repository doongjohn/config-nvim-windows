return {
	-- multi cursor
	"mg979/vim-visual-multi",
	branch = "master",
	event = "VeryLazy",
	init = function()
		vim.g.VM_theme = "codedark"
		vim.g.VM_leader = "\\"
		-- vim.g.VM_maps = {}
	end,
}
