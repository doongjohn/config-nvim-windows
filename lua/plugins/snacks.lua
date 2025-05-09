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
			picker = {
				sources = {
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
	end,
}
