return {
	"nvimtools/hydra.nvim",
	event = "UIEnter",
	config = function()
		local hydra = require("hydra")

		hydra({
			name = "side scroll",
			mode = "n",
			body = "z",
			heads = {
				{ "h", "zh" },
				{ "l", "zl", { desc = "" } },
				{ "H", "zH" },
				{ "L", "zL", { desc = "half screen " } },
			},
		})

		hydra({
			name = "window",
			config = {
				on_key = function()
					vim.cmd(":SatelliteRefresh")
				end,
			},
			mode = "n",
			body = "<c-w>",
			heads = {
				{ "<", "<c-w><" },
				{ ">", "<c-w>>", { desc = "󰤼 resize" } },
				{ ",", "<c-w>-" },
				{ ".", "<c-w>+", { desc = "󰤻 resize" } },
			},
		})

		hydra({
			name = "git",
			config = {
				color = "pink",
				invoke_on_body = true,
				hint = {
					type = "window",
					offset = -1,
				},
			},
			mode = "n",
			body = "<leader>G",
			heads = {
				{ "n", "<cmd>Gitsigns next_hunk<cr>", { desc = "next hunk" } },
				{ "N", "<cmd>Gitsigns prev_hunk<cr>", { desc = "prev hunk" } },
				{ "p", "<cmd>Gitsigns preview_hunk<cr>", { desc = "preview hunk" } },
				{ "r", "<cmd>Gitsigns reset_hunk<cr>", { desc = "reset hunk" } },
				{ "q", nil, { desc = "exit", exit = true, nowait = true } },
			},
		})
	end,
}
