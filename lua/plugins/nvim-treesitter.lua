return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = "config",
			callback = function(e)
				local ft = vim.bo[e.buf].ft
				local lang = vim.treesitter.language.get_lang(ft)
				local ok, _ = pcall(vim.treesitter.language.inspect, lang)
				if ok then
					vim.print(ft)
					vim.defer_fn(function()
						pcall(vim.treesitter.start)
					end, 0)
				end
			end,
		})

		require("nvim-treesitter").install({
			-- markup
			"markdown",
			"rst",
			-- data
			"xml",
			"json",
			"ini",
			"toml",
			"yaml",
			-- shell
			"bash",
			"fish",
			"nu",
			"powershell",
			-- tool
			"make",
			"cmake",
			"ninja",
			"regex",
			"vim",
			"vimdoc",
			-- git
			"diff",
			"gitcommit",
			"git_rebase",
			"git_config",
			"gitignore",
			"gitattributes",
			-- programming lanuage
			"c",
			"cpp",
			"rust",
			"zig",
			"odin",
			"c_sharp",
			"java",
			"kotlin",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"lua",
			"python",
			"commonlisp",
			"gdscript",
			-- web dev
			"html",
			"css",
			"javascript",
			"jsdoc",
			"typescript",
			"tsx",
			"astro",
			"svelte",
			"vue",
			-- shader
			"wgsl",
			"glsl",
			"hlsl",
		})
	end,
}
