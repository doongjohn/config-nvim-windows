return {
	"mhartington/formatter.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local util = require("formatter.util")

		local opts_per_filetype = {
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

		local prettier_filetypes = {
			"markdown",
			"json",
			"html",
			"css",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
		}
		for _, ft in ipairs(prettier_filetypes) do
			opts_per_filetype[ft] = {
				function()
					local using_prettier = vim.fn.filereadable("./node_modules/.bin/prettier") == 1
					if using_prettier then
						return {
							exe = "prettier",
							args = {
								"--stdin-filepath",
								util.escape_path(util.get_current_buffer_file_path()),
							},
							stdin = true,
							try_node_modules = true,
						}
					end

					local using_deno = vim.fn.filereadable("./deno.json") == 1
					if using_deno then
						return require("formatter.defaults.denofmt")()
					end

					-- default
					vim.lsp.buf.format()
					return nil
				end,
			}
		end

		require("formatter").setup({
			filetype = opts_per_filetype,
		})
	end,
}
