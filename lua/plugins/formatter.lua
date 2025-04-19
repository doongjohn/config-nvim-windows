return {
	"mhartington/formatter.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local filetype = {
			["*"] = {
				function()
					local config_filetype = require("formatter.config").values.filetype
					if config_filetype[vim.bo.filetype] == nil then
						vim.lsp.buf.format()
					end
					return nil
				end,
			},
			lua = {
				require("formatter.filetypes.lua").stylua,
			},
		}

		local util = require("formatter.util")
		local prettier_filetypes = { "markdown", "json", "html", "css", "javascript", "typescript", "svelte" }
		for _, ft in ipairs(prettier_filetypes) do
			filetype[ft] = {
				function()
					if vim.fn.filereadable("./node_modules/.bin/prettier") == 0 then
						vim.lsp.buf.format()
						return nil
					end
					return {
						exe = "prettier",
						args = {
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
						},
						stdin = true,
						try_node_modules = true,
					}
				end,
			}
		end

		require("formatter").setup({
			filetype = filetype,
		})
	end,
}
