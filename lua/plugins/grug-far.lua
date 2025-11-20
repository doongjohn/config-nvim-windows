return {
	"magicduck/grug-far.nvim",
	config = function()
		local ripgrep_extraArgs = "--no-heading -.n"
		local exclude = Config.file.get_exclude()
		for _, item in ipairs(exclude) do
			ripgrep_extraArgs = ripgrep_extraArgs .. " -g!" .. item
		end

		require("grug-far").setup({
			showCompactInputs = true,
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
