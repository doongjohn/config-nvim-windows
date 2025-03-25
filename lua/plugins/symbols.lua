return {
	"oskarrrrrrr/symbols.nvim",
	cmd = "SymbolsToggle",
	config = function()
		local r = require("symbols.recipes")
		require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {})
	end,
}
