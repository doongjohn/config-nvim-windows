return {
	"oskarrrrrrr/symbols.nvim",
	cmd = "SymbolsToggle",
	config = function()
		local r = require("symbols.recipes")
		require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
			sidebar = {
				auto_resize = {
					enabled = true,
					min_width = 30,
					max_width = 40,
				},
				show_inline_details = true,
			},
		})
	end,
}
