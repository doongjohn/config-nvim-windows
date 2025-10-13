return {
	"refractalize/oil-git-status.nvim",
	dependencies = {
		"stevearc/oil.nvim",
	},
	ft = "oil",
	opts = {
		symbols = {
			index = {
				["!"] = "#",
				["?"] = "?",
				["A"] = "+",
				["C"] = "C",
				["D"] = "-",
				["M"] = "~",
				["R"] = "󱀱",
				["T"] = "T",
				["U"] = "",
				[" "] = " ",
			},
			working_tree = {
				["!"] = "#",
				["?"] = "?",
				["A"] = "+",
				["C"] = "C",
				["D"] = "-",
				["M"] = "~",
				["R"] = "󱀱",
				["T"] = "T",
				["U"] = "",
				[" "] = " ",
			},
		},
	},
}
