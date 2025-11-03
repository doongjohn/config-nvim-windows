return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
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
			bigfile = {
				enabled = true,
			},
			input = {
				prompt_pos = "left",
				icon_pos = "left",
				expand = false,
			},
			picker = {
				sources = {
					files = {
						cmd = "fd",
						args = { "--no-ignore-vcs" },
						hidden = true,
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
					backdrop = false,
					position = "float",
					relative = "cursor",
					noautocmd = true,
					border = "none",
					height = 1,
					row = 1,
					col = 0,
					wo = {
						winhighlight = "NormalFloat:NormalFloat",
						cursorline = false,
					},
				},
			},
		})

		local command_palette_items = {
			{
				category = "Editor",
				label = "Plugins",
				cmd = "Lazy home",
			},
			{
				category = "Editor",
				label = "Help",
				callback = function()
					Snacks.picker.help()
				end,
			},
			{
				category = "Editor",
				label = "Sessions",
				cmd = "SessionManager available_commands",
			},
			{
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
				category = "Editor",
				label = "Keymaps",
				callback = function()
					Snacks.picker.keymaps()
				end,
			},
			{
				category = "Editor",
				label = "Registers",
				callback = function()
					Snacks.picker.registers()
				end,
			},
			{
				category = "Editor",
				label = "Highlights",
				callback = function()
					Snacks.picker.highlights()
				end,
			},
			{
				category = "Editor",
				label = "Tab new",
				cmd = "tabnew",
			},
			{
				category = "Editor",
				label = "Tab close",
				cmd = "tabclose",
			},
			{
				category = "Editor",
				label = "Center",
				cmd = "NoNeckPain",
			},
			{
				category = "Editor",
				label = "Go to nvim config",
				callback = function()
					local config_path = vim.fn.stdpath("config")
					vim.cmd("cd " .. config_path)
					print("cd " .. vim.fn.fnamemodify(config_path, ":~"))
				end,
			},
			{
				category = "Search",
				label = "Current dir",
				callback = function()
					require("grug-far").open()
				end,
			},
			{
				category = "Search",
				label = "Current buf",
				callback = function()
					require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
				end,
			},
			{
				category = "Search",
				label = "Document symbols",
				callback = function()
					Snacks.picker.lsp_symbols()
				end,
			},
			{
				category = "File",
				label = "Recent",
				callback = function()
					Snacks.picker.recent()
				end,
			},
			{
				category = "File",
				label = "Format",
				callback = function()
					vim.cmd("up")
					vim.cmd("FormatWriteLock")
					vim.cmd("up")
				end,
			},
			{
				category = "File",
				label = "Yank all",
				cmd = "%y",
			},
			{
				category = "Git",
				label = "Neogit",
				cmd = "Neogit",
			},
			{
				category = "Git",
				label = "File history",
				cmd = "DiffviewFileHistory %",
			},
			{
				category = "Lsp",
				label = "Inlay hint toggle",
				callback = function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
				end,
			},
			{
				category = "Lsp",
				label = "References",
				cmd = "Glance references",
			},
			{
				category = "Lsp",
				label = "Symbols",
				cmd = "SymbolsToggle",
			},
			{
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

		for _, item in ipairs(command_palette_items) do
			item.text = item.category .. " " .. item.label
		end

		vim.keymap.set("n", "<c-p>", function()
			Snacks.picker.pick({
				title = "Command palette",
				items = command_palette_items,
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
				layout = "vscode",
			})
		end)
	end,
}
