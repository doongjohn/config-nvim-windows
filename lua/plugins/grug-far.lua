return {
	"magicduck/grug-far.nvim",
	config = function()
		local ripgrep_extraArgs = ""
			.. "--no-heading -.n"
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
			.. " -g!.godot"

		local exclude = function(glob)
			ripgrep_extraArgs = ripgrep_extraArgs .. " -g!" .. glob
		end

		-- exclude: unity engine
		if vim.fn.isdirectory("./Assets") and vim.fn.filereadable("./Assembly-CSharp.csproj") then
			exclude("*.meta")
			exclude("*.asset")
			exclude("*.unity")
			exclude("*.prefab")
			exclude("*.mat")
			exclude("*.physicMaterial")
			exclude("*.inputactions")
			exclude("Logs/*")
			exclude("Temp/*")
			exclude("Library/*")
			exclude("Packages/*")
			exclude("ProjectSettings/*")
			exclude("UserSettings/*")
			exclude("UIElementsSchema/*")
		end

		require("grug-far").setup({
			engines = {
				ripgrep = {
					extraArgs = ripgrep_extraArgs,
				},
			},
			windowCreationCommand = "vert topleft split",
			wrap = false,
			openTargetWindow = {
				preferredLocation = "right",
			},
		})

		vim.api.nvim_set_hl(0, "GrugFarResultsMatch", { link = "DiffText" })
		vim.api.nvim_set_hl(0, "GrugFarResultsMatchAdded", { link = "DiffAdd" })
		vim.api.nvim_set_hl(0, "GrugFarResultsMatchRemoved", { link = "DiffDelete" })
	end,
}
