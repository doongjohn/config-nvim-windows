return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	keys = {
		{
			"<leader>fl",
			function()
				Snacks.picker.lines()
			end,
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = "config",
			callback = function()
				if #vim.bo.buftype ~= 0 or vim.api.nvim_win_get_config(0).relative ~= "" then
					return
				end
				vim.keymap.set("n", "<space>", Snacks.picker.files, { buffer = true })
			end,
		})
	end,
	config = function()
		require("snacks").setup({
			bigfile = { enabled = true },
			input = { enabled = true },
			picker = {
				sources = {
					files = {
						hidden = true,
						ignored = true,
						exclude = Config.search_get_exclude(),
					},
					lines = {
						win = {
							preview = {
								wo = {
									winbar = "",
								},
							},
						},
					},
				},
				layout = {
					preset = "default",
					layout = {
						backdrop = false,
					},
				},
			},
			styles = {
				input = {
					position = "float",
					relative = "cursor",
					height = 1,
					row = 1,
					col = 0,
					border = "none",
					wo = {
						winhighlight = "NormalFloat:NormalFloat",
						cursorline = false,
					},
				},
			},
		})

		---@type snacks.picker.finder.Item[]
		local command_palette = {
			{
				text = "",
				category = "Editor",
				label = "Plugins",
				cmd = "Lazy home",
			},
			{
				text = "",
				category = "Editor",
				label = "Sessions",
				cmd = "SessionManager available_commands",
			},
			{
				text = "",
				category = "Editor",
				label = "Messages",
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
				text = "",
				category = "Editor",
				label = "Command history",
				callback = Snacks.picker.command_history,
			},
			{
				text = "",
				category = "Editor",
				label = "Registers",
				callback = Snacks.picker.registers,
			},
			{
				text = "",
				category = "Editor",
				label = "Highlights",
				callback = Snacks.picker.highlights,
			},
			{
				text = "",
				category = "Editor",
				label = "Help",
				callback = Snacks.picker.help,
			},
			{
				text = "",
				category = "Editor",
				label = "Tab new",
				cmd = "tabnew",
			},
			{
				text = "",
				category = "Editor",
				label = "Tab close",
				cmd = "tabclose",
			},
			{
				text = "",
				category = "Editor",
				label = "Go to nvim config",
				callback = function()
					local config_path = vim.fn.stdpath("config")
					vim.cmd("cd " .. config_path)
					print("cd " .. vim.fn.fnamemodify(config_path, ":~"))
				end,
			},
			{
				text = "",
				category = "Search",
				label = "Current dir",
				callback = function()
					require("grug-far").open()
				end,
			},
			{
				text = "",
				category = "Search",
				label = "Current buf",
				callback = function()
					require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
				end,
			},
			{
				text = "",
				category = "Search",
				label = "Document symbols",
				callback = Snacks.picker.lsp_symbols,
			},
			{
				text = "",
				category = "File",
				label = "Recent",
				callback = Snacks.picker.recent,
			},
			{
				text = "",
				category = "File",
				label = "Format",
				callback = function()
					vim.cmd("up")
					vim.cmd("FormatWriteLock")
					vim.cmd("up")
				end,
			},
			{
				text = "",
				category = "File",
				label = "Yank all",
				cmd = "%y",
			},
			{
				text = "",
				category = "Git",
				label = "Neogit",
				cmd = "Neogit",
			},
			{
				text = "",
				category = "Git",
				label = "File history",
				cmd = "DiffviewFileHistory %",
			},
			{
				text = "",
				category = "Lsp",
				label = "Inlay hint toggle",
				callback = function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
				end,
			},
			{
				text = "",
				category = "Lsp",
				label = "References",
				cmd = "Glance references",
			},
			{
				text = "",
				category = "Lsp",
				label = "Symbols",
				cmd = "SymbolsToggle",
			},
			{
				text = "",
				category = "Lsp",
				label = "(clangd) Switch source header",
				callback = function()
					for _, v in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
						if v.config.name == "clangd" then
							vim.cmd("LspClangdSwitchSourceHeader")
							return
						end
					end
					vim.notify("clangd is not active", vim.log.levels.WARN)
				end,
			},
			{
				text = "",
				category = "Lsp",
				label = "(clangd) Switch source header in vsplit",
				callback = function()
					for _, v in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
						if v.config.name == "clangd" then
							vim.cmd("vs | LspClangdSwitchSourceHeader")
							return
						end
					end
					vim.notify("clangd is not active", vim.log.levels.WARN)
				end,
			},
		}

		for _, item in ipairs(command_palette) do
			item.text = item.category .. " " .. item.label
		end

		vim.keymap.set("n", "<c-p>", function()
			Snacks.picker.pick({
				title = "Command palette",
				items = command_palette,
				format = function(item, _)
					return {
						{ item.category, "Comment" },
						{ " ", virtual = true },
						{ item.label, "SnacksPickerFile" },
					}
				end,
				confirm = function(picker, item)
					return picker:norm(function()
						picker:close()
						if item then
							if item.cmd then
								vim.cmd(item.cmd)
							elseif item.callback then
								item.callback()
							end
						end
					end)
				end,
				prompt = "  ",
				layout = "vscode",
			})
		end)
	end,
}
