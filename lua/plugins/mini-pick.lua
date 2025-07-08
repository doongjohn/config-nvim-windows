return {
	"echasnovski/mini.pick",
	version = "*",
	lazy = false,
	init = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = "config",
			callback = function()
				if #vim.bo.buftype ~= 0 or vim.api.nvim_win_get_config(0).relative ~= "" then
					return
				end
				vim.keymap.set("n", "<space>", MiniPick.registry.files, { buffer = true })
			end,
		})
	end,
	config = function()
		require("mini.pick").setup({
			window = {
				config = function()
					local height = math.floor(0.618 * vim.o.lines)
					local width = math.floor(0.618 * vim.o.columns)
					return {
						anchor = "NW",
						height = height,
						width = width,
						row = 1,
						col = math.floor(0.5 * (vim.o.columns - width)),
					}
				end,
			},
		})

		MiniPick.registry.old_files = function()
			local old_files = vim.v.oldfiles
			local done = {} ---@type table<string, boolean>
			local files = {} ---@type string[]
			local i = 0
			for f = i + 1, #old_files do
				i = f
				local file = old_files[f]
				file = vim.fn.fnamemodify(file, ":p")
				file = vim.fs.normalize(file, { _fast = true, expand_env = false })
				local show = not done[file] and vim.uv.fs_stat(file)
				if show then
					done[file] = true
					table.insert(files, file)
				end
			end
			MiniPick.start({
				source = {
					name = "Old files",
					items = files,
					show = function(buf_id, items, query)
						return MiniPick.default_show(buf_id, items, query, { show_icons = true })
					end,
				},
			})
		end

		MiniPick.registry.files = function()
			local command = vim.tbl_extend(
				"keep",
				{ "fd", "-tf", "-u", "--no-follow", "--color=never" },
				vim.tbl_map(function(item)
					return "-E=" .. item
				end, Config.search_get_exclude())
			)
			local show_with_icons = function(buf_id, items, query)
				return MiniPick.default_show(buf_id, items, query, { show_icons = true })
			end
			local source = { name = "Files (fd)", show = show_with_icons }
			return MiniPick.builtin.cli({ command = command }, { source = source })
		end

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
					MiniPick.registry.old_files()
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

		vim.keymap.set("n", "<c-p>", function()
			local orig_win = vim.api.nvim_get_current_win()
			local orig_buf = vim.api.nvim_get_current_buf()
			MiniPick.start({
				source = {
					name = "Command palette",
					items = vim.tbl_map(function(item)
						return {
							text = (item.category .. " " .. item.label):lower(),
							data = item,
						}
					end, command_palette_items),
					choose = function(item)
						vim.api.nvim_set_current_win(orig_win)
						vim.api.nvim_set_current_buf(orig_buf)
						vim.schedule(function()
							local data = item.data
							if data.cmd then
								vim.cmd(data.cmd)
							elseif data.callback then
								data.callback()
							end
						end)
					end,
					show = function(buf_id, items)
						local lines = vim.tbl_map(function(item)
							return string.format("%-8s %s", item.data.category, item.data.label)
						end, items)
						vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)

						local ns = vim.api.nvim_create_namespace("CommandPaletteShow")
						vim.api.nvim_buf_clear_namespace(buf_id, ns, 0, -1)
						for i, item in ipairs(items) do
							vim.api.nvim_buf_set_extmark(buf_id, ns, i - 1, 0, {
								end_col = #item.data.category,
								hl_group = "Comment",
							})
						end
					end,
				},
				window = {
					config = function()
						local width = math.floor(0.618 * vim.o.columns)
						return {
							anchor = "NW",
							height = 10,
							width = width,
							row = 1,
							col = math.floor(0.5 * (vim.o.columns - width)),
						}
					end,
				},
			})
		end)
	end,
}
