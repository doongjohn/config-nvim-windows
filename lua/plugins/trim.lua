return {
	-- trim trailing whitespace
	"cappyzawa/trim.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		ft_blocklist = {
			"markdown",
		},
		patterns = {
			[[%s/\s\+$//e]], -- trailing whitespace
			[[%s/\%^\n\+//]], -- top empty lines
			[[%s/\($\n\s*\)\+\%$//]], -- bot empty lines
		},
	},
}
