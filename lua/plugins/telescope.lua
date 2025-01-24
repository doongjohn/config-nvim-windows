return {
	-- telescope
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			-- https://github.com/nvim-telescope/telescope-fzf-native.nvim/issues/128#issuecomment-2235208849
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && "
				.. "cmake --build build --config Release && "
				.. "cmake --install build --prefix build",
		},
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>fb", '<cmd>Telescope live_grep search_dirs={"%"}<cr>' },
	},
	init = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = "config",
			callback = function()
				if #vim.bo.buftype ~= 0 or vim.api.nvim_win_get_config(0).relative ~= "" then
					return
				end
				vim.keymap.set("n", "<space>", "<cmd>Telescope find_files<cr>", { buffer = true })
			end,
		})
	end,
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		-- https://github.com/MagicDuck/grug-far.nvim/pull/305
		local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1
		local vimfnameescape = vim.fn.fnameescape
		local winfnameescape = function(path)
			local escaped_path = vimfnameescape(path)
			if is_windows then
				local need_extra_esc = path:find("[%[%]`%$~]")
				local esc = need_extra_esc and "\\\\" or "\\"
				escaped_path = escaped_path:gsub("\\[%(%)%^&;]", esc .. "%1")
				if need_extra_esc then
					escaped_path = escaped_path:gsub("\\\\['` ]", "\\%1")
				end
			end
			return escaped_path
		end

		local select_default = function(prompt_bufnr)
			vim.fn.fnameescape = winfnameescape
			local result = actions.select_default(prompt_bufnr, "default")
			vim.fn.fnameescape = vimfnameescape
			return result
		end

		telescope.setup({
			defaults = {
				border = {},
				prompt_prefix = "   ",
				selection_caret = "  ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				path_display = { "truncate" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--hidden",
					"-g!.git",
					"-g!.github",
					"-g!*cache",
					"-g!obj",
					"-g!.objs",
					"-g!.deps",
					"-g!.venv",
					"-g!bin",
					"-g!out",
					"-g!build",
					"-g!target",
					"-g!vendor",
					"-g!dist",
					"-g!node_modules",
					"-g!.svelte-kit",
					"-g!__pycache__",
					"-g!zig-out",
					"-g!.godot",
				},
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<cr>"] = select_default,
					},
					n = {
						["<cr>"] = select_default,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"fd",
						"-tf",
						"-H",
						"--no-ignore-vcs",
						"--strip-cwd-prefix",

						-- exclude files
						"-E=*.a",
						"-E=*.o",
						"-E=*.so",
						"-E=*.obj",
						"-E=*.lib",
						"-E=*.dll",
						"-E=*.exe",
						"-E=*.ilk",
						"-E=*.pdb",

						"-E=*.pdf",
						"-E=*.png",
						"-E=*.jpg",
						"-E=*.jpeg",
						"-E=*.gif",
						"-E=*.ttf",
						"-E=*.otf",
						"-E=*.fbx",
						"-E=*.vrm",

						-- exclude folders
						"-E=.git/",
						"-E=.github/",
						"-E=*cache/",
						"-E=obj/",
						"-E=.objs/",
						"-E=.deps/",
						"-E=.venv/",
						"-E=bin/",
						"-E=out/",
						"-E=build/",
						"-E=target/",
						"-E=vendor/",
						"-E=dist/",
						"-E=node_modules/",
						"-E=.svelte-kit/",
						"-E=__pycache__/",
						"-E=zig-out/",
						"-E=.godot/",
					},
					hidden = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_file_sorter = true,
					override_generic_sorter = true,
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
