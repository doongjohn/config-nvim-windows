return {
	"magicduck/grug-far.nvim",
	config = function()
		require("grug-far").setup({
			engines = {
				ripgrep = {
					extraArgs = "--no-heading -.n"
						.. " -g!.git"
						.. " -g!.github"
						.. " -g!*cache"
						.. " -g!obj"
						.. " -g!.objs"
						.. " -g!.deps"
						.. " -g!.venv"
						.. " -g!bin"
						.. " -g!out"
						.. " -g!build"
						.. " -g!target"
						.. " -g!vendor"
						.. " -g!dist"
						.. " -g!node_modules"
						.. " -g!.svelte-kit"
						.. " -g!__pycache__"
						.. " -g!zig-out"
						.. " -g!.godot",
				},
			},
			windowCreationCommand = "vert topleft split",
			wrap = false,
		})

		vim.api.nvim_set_hl(0, "GrugFarResultsMatch", { link = "DiffText" })
		vim.api.nvim_set_hl(0, "GrugFarResultsMatchAdded", { link = "DiffAdd" })
		vim.api.nvim_set_hl(0, "GrugFarResultsMatchRemoved", { link = "DiffDelete" })
	end,
}
