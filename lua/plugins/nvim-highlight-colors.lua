return {
	"brenoprata10/nvim-highlight-colors",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		render = "virtual",
		virtual_symbol = "",
		virtual_symbol_position = "inline",
		enable_tailwind = true,
		exclude_buffer = function(bufnr)
			local ft = vim.api.nvim_get_option_value("ft", { buf = bufnr })
			local enabled_ft = {
				"html",
				"css",
				"postcss",
				"less",
				"scss",
				"sass",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"vue",
				"svelte",
				"astro",
			}
			if vim.list_contains(enabled_ft, ft) then
				return false
			end
			return true
		end,
	},
}
