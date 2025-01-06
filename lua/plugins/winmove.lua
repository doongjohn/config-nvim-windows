return {
	"MisanthropicBit/winmove.nvim",
	keys = {
		{
			"<c-w>m",
			function()
				require("winmove").start_mode("move")
			end,
		},
	},
}
