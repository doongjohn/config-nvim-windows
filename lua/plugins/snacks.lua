return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
		},
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
		local exclude = {}
		local add_exclude = function(pattern)
			table.insert(exclude, pattern)
		end

		-- exclude: files
		add_exclude("*.a")
		add_exclude("*.o")
		add_exclude("*.so")
		add_exclude("*.obj")
		add_exclude("*.lib")
		add_exclude("*.dll")
		add_exclude("*.exe")
		add_exclude("*.ilk")
		add_exclude("*.pdb")
		add_exclude("*.pdf")
		add_exclude("*.png")
		add_exclude("*.jpg")
		add_exclude("*.jpeg")
		add_exclude("*.gif")
		add_exclude("*.ttf")
		add_exclude("*.otf")
		add_exclude("*.psd")
		add_exclude("*.fbx")
		add_exclude("*.vrm")

		-- exclude: folders
		add_exclude(".git/")
		add_exclude(".github/")
		add_exclude("*cache/")
		add_exclude("obj/")
		add_exclude(".objs/")
		add_exclude(".deps/")
		add_exclude(".venv/")
		add_exclude("bin/")
		add_exclude("out/")
		add_exclude("build/")
		add_exclude("target/")
		add_exclude("vendor/")
		add_exclude("dist/")
		add_exclude("node_modules/")
		add_exclude(".svelte-kit/")
		add_exclude("__pycache__/")
		add_exclude("zig-out/")
		add_exclude(".godot/")

		-- exclude: unity engine
		if vim.fn.isdirectory("./Assets") and vim.fn.filereadable("./Assembly-CSharp.csproj") then
			add_exclude("*.meta")
			add_exclude("*.asset")
			add_exclude("*.unity")
			add_exclude("*.prefab")
			add_exclude("*.mat")
			add_exclude("*.physicMaterial")
			add_exclude("*.inputactions")
			add_exclude("Logs/*")
			add_exclude("Temp/*")
			add_exclude("Library/*")
			add_exclude("Packages/*")
			add_exclude("ProjectSettings/*")
			add_exclude("UserSettings/*")
			add_exclude("UIElementsSchema/*")
		end

		require("snacks").setup({
			bigfile = { enabled = true },
			input = { enabled = true },
			explorer = { enabled = true },
			picker = {
				sources = {
					explorer = {
						hidden = true,
						win = {
							list = {
								wo = {
									scrolloff = 5,
								},
							},
						},
					},
					files = {
						hidden = true,
						exclude = exclude,
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
				category = "Editor",
				label = "Plugins",
				text = "",
				cmd = "Lazy home",
			},
			{
				category = "Editor",
				label = "Sessions",
				text = "",
				cmd = "SessionManager available_commands",
			},
			{
				category = "Editor",
				label = "Messages",
				text = "",
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
				label = "Command history",
				text = "",
				callback = Snacks.picker.command_history,
			},
			{
				category = "Editor",
				label = "Registers",
				text = "",
				callback = Snacks.picker.registers,
			},
			{
				category = "Editor",
				label = "Highlights",
				text = "",
				callback = Snacks.picker.highlights,
			},
			{
				category = "Editor",
				label = "Help",
				text = "",
				callback = Snacks.picker.help,
			},
			{
				category = "Editor",
				label = "Tab new",
				text = "",
				cmd = "tabnew",
			},
			{
				category = "Editor",
				label = "Tab close",
				text = "",
				cmd = "tabclose",
			},
			{
				category = "Editor",
				label = "Go to nvim config",
				text = "",
				callback = function()
					local config_path = vim.fn.stdpath("config")
					vim.cmd("cd " .. config_path)
					print("cd " .. vim.fn.fnamemodify(config_path, ":~"))
				end,
			},
			{
				category = "Search",
				label = "Current dir",
				text = "",
				callback = function()
					require("grug-far").open()
				end,
			},
			{
				category = "Search",
				label = "Current buf",
				text = "",
				callback = function()
					require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
				end,
			},
			{
				category = "Search",
				label = "Document symbols",
				text = "",
				callback = Snacks.picker.lsp_symbols,
			},
			{
				category = "File",
				label = "Recent",
				text = "",
				callback = Snacks.picker.recent,
			},
			{
				category = "File",
				label = "Format",
				text = "",
				callback = function()
					vim.cmd("up")
					vim.cmd("FormatWriteLock")
					vim.cmd("up")
				end,
			},
			{
				category = "File",
				label = "Yank all",
				text = "",
				cmd = "%y",
			},
			{
				category = "Git",
				label = "Neogit",
				text = "",
				cmd = "Neogit",
			},
			{
				category = "Git",
				label = "File history",
				text = "",
				cmd = "DiffviewFileHistory %",
			},
			{
				category = "Lsp",
				label = "Inlay hint toggle",
				text = "",
				callback = function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
				end,
			},
			{
				category = "Lsp",
				label = "References",
				text = "",
				cmd = "Glance references",
			},
			{
				category = "Lsp",
				label = "Symbols",
				text = "",
				cmd = "SymbolsToggle",
			},
			{
				category = "Lsp",
				label = "(clangd) Switch source header",
				text = "",
				callback = function()
					for _, v in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
						if v.config.name == "clangd" then
							vim.cmd("ClangdSwitchSourceHeader")
							return
						end
					end
					vim.notify("clangd is not active", vim.log.levels.WARN)
				end,
			},
			{
				category = "Lsp",
				label = "(clangd) Switch source header in vsplit",
				text = "",
				callback = function()
					for _, v in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
						if v.config.name == "clangd" then
							vim.cmd("vs | ClangdSwitchSourceHeader")
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
				layout = { preset = "vscode" },
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
						if item.cmd then
							vim.cmd(item.cmd)
						elseif item.callback then
							item.callback()
						end
					end)
				end,
			})
		end)
	end,
}
