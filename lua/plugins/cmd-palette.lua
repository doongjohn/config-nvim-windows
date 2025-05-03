return {
	"koenverburg/cmd-palette.nvim",
	dependencies = {
		"stevearc/dressing.nvim",
	},
	lazy = false,
	config = function()
		local opts = {
			-- editor
			{
				label = "[editor] plugins",
				cmd = "Lazy home",
			},
			{
				label = "[editor] sessions",
				cmd = "SessionManager available_commands",
			},
			{
				label = "[editor] messages",
				callback = function()
					vim.cmd("split")
					local buf = vim.api.nvim_create_buf(false, true)
					vim.api.nvim_buf_call(buf, function()
						vim.cmd([[put =execute('messages')]])
						vim.cmd([[%s/\%^\n\+//]])
					end)
					vim.api.nvim_win_set_buf(0, buf)
					vim.cmd("norm GG")
				end,
			},
			{
				label = "[editor] command history",
				cmd = "Telescope command_history",
			},
			{
				label = "[editor] registers",
				cmd = "Telescope registers",
			},
			{
				label = "[editor] tab new",
				cmd = "tabnew",
			},
			{
				label = "[editor] tab close",
				cmd = "tabclose",
			},
			{
				label = "[editor] cd → nvim config",
				callback = function()
					local config_path = vim.fn.stdpath("config")
					vim.cmd("cd " .. config_path)
					print("cd " .. vim.fn.fnamemodify(config_path, ":~"))
				end,
			},

			-- file
			{
				label = "[file] recent",
				cmd = "Telescope oldfiles",
			},
			{
				label = "[file] format",
				callback = function()
					vim.cmd("up")
					vim.cmd("FormatWriteLock")
					vim.cmd("up")
				end,
			},
			{
				label = "[file] yank all",
				cmd = "%y",
			},

			-- search
			{
				label = "[search] all files",
				callback = function()
					require("grug-far").open()
				end,
			},
			{
				label = "[search] current file",
				callback = function()
					require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
				end,
			},
			{
				label = "[search] document symbols",
				cmd = "Telescope lsp_document_symbols",
			},

			-- git
			{
				label = "[git] neogit",
				cmd = "Neogit",
			},
			{
				label = "[git] file history",
				cmd = "DiffviewFileHistory %",
			},

			-- lsp
			{
				label = "[lsp] inlay hint toggle",
				callback = function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
				end,
			},
			{
				label = "[lsp] references",
				cmd = "Glance references",
			},
			{
				label = "[lsp] symbols",
				cmd = "SymbolsToggle",
			},
			{
				label = "[lsp] c, cpp switch source ↔ header",
				callback = function()
					for _, v in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
						if v.config.name == "clangd" then
							vim.cmd("ClangdSwitchSourceHeader")
							break
						end
					end
					print("[lsp] c, cpp switch source ↔ header: clangd not active")
				end,
			},
			{
				label = "[lsp] c, cpp switch source ↔ header (v-split)",
				callback = function()
					for _, v in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
						if v.config.name == "clangd" then
							vim.cmd("vs | ClangdSwitchSourceHeader")
							break
						end
					end
					print("[lsp] c, cpp switch source ↔ header (v-split): clangd not active")
				end,
			},
		}

		vim.keymap.set("n", "<c-p>", function()
			local palette = require("cmd-palette")
			palette.setup(opts)
			palette.show()
		end)
	end,
}
