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
			body = "<leader>g",
			heads = {
				{ "n", "<cmd>Gitsigns next_hunk<cr>", { desc = "next hunk" } },
				{ "N", "<cmd>Gitsigns prev_hunk<cr>", { desc = "prev hunk" } },
				{ "p", "<cmd>Gitsigns preview_hunk<cr>", { desc = "preview hunk" } },
				{ "r", "<cmd>Gitsigns reset_hunk<cr>", { desc = "reset hunk" } },
				{ "q", nil, { desc = "exit", exit = true, nowait = true } },
			},
		})

		hydra({
			name = "dap",
			config = {
				color = "pink",
				invoke_on_body = true,
				hint = {
					type = "window",
					offset = -1,
				},
			},
			mode = "n",
			body = "<leader>d",
			heads = {
				{
					"<c-b>",
					function()
						require("dap").toggle_breakpoint()
					end,
					{ desc = "toggle bp" },
				},
				{
					"<c-x>",
					function()
						require("dap").clear_breakpoints()
					end,
					{ desc = "clear bp" },
				},
				{
					"c",
					function()
						require("dap").continue()
					end,
					{ desc = "continue" },
				},
				{
					"n",
					function()
						require("dap").step_over()
					end,
					{ desc = "step-over" },
				},
				{
					"s",
					function()
						require("dap").step_into()
					end,
					{ desc = "step-into" },
				},
				{
					"o",
					function()
						require("dap").step_over()
					end,
					{ desc = "step-out" },
				},
				{
					"i",
					function()
						require("dap.ui.widgets").hover()
					end,
					{ desc = "inspect" },
				},
				{
					"t",
					function()
						require("dap").terminate()
					end,
					{ desc = "terminate" },
				},
				{
					"q",
					nil,
					{ desc = "exit", exit = true, nowait = true },
				},
			},
		})
	end,
}
