return {
	"magicduck/grug-far.nvim",
	config = function()
		local ripgrep_extraArgs = "--no-heading -.n"

		local exclude = function(glob)
			ripgrep_extraArgs = ripgrep_extraArgs .. " -g!" .. glob
		end

		-- exclude: files
		exclude("*.a")
		exclude("*.o")
		exclude("*.so")
		exclude("*.obj")
		exclude("*.lib")
		exclude("*.dll")
		exclude("*.exe")
		exclude("*.ilk")
		exclude("*.pdb")
		exclude("*.pdf")
		exclude("*.png")
		exclude("*.jpg")
		exclude("*.jpeg")
		exclude("*.gif")
		exclude("*.ttf")
		exclude("*.otf")
		exclude("*.psd")
		exclude("*.fbx")
		exclude("*.vrm")

		-- exclude: folders
		exclude(".git/")
		exclude(".github/")
		exclude("*cache/")
		exclude("obj/")
		exclude(".objs/")
		exclude(".deps/")
		exclude(".venv/")
		exclude("bin/")
		exclude("out/")
		exclude("build/")
		exclude("target/")
		exclude("vendor/")
		exclude("dist/")
		exclude("node_modules/")
		exclude(".svelte-kit/")
		exclude("__pycache__/")
		exclude("zig-out/")
		exclude(".godot/")

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
