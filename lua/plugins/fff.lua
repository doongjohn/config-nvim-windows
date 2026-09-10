return {
	"dmtrKovalenko/fff",
	lazy = false,
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	init = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = "config",
			callback = function()
				if #vim.bo.buftype ~= 0 or vim.api.nvim_win_get_config(0).relative ~= "" then
					return
				end
				vim.keymap.set("n", "<space>", function()
					require("fff").find_files()
				end, { buffer = true })
			end,
		})
	end,
	opts = {
		prompt = "",
		title = "Find file",
		layout = {
			prompt_position = "top",
		},
		file_picker = {
			fuzzy_query_highlighting = true,
		},
		keymaps = {
			close = "<c-c>",
		},
		frecency = {
			enabled = false,
		},
		logging = {
			enabled = false,
		},
	},
}
