return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	init = function()
		vim.treesitter.language.register("xml", { "xml", "xsd", "xsl", "xslt", "svg", "xaml", "axaml" })
		vim.treesitter.language.register("powershell", { "ps1" })
		vim.treesitter.language.register("crystal", { "cr" })

		vim.api.nvim_create_autocmd("User", {
			group = "config",
			pattern = "TSUpdate",
			callback = function()
				---@diagnostic disable-next-line: missing-fields
				require("nvim-treesitter.parsers").crystal = {
					---@diagnostic disable-next-line: missing-fields
					install_info = {
						url = "https://github.com/crystal-lang-tools/tree-sitter-crystal",
						generate = false,
						generate_from_json = false,
						queries = "queries/nvim",
					},
				}
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = "config",
			callback = function()
				local bt = vim.bo.bt
				if bt ~= "" then
					return
				end

				local ft = vim.bo.ft
				local ts_lang = vim.treesitter.language.get_lang(ft)
				if ts_lang == nil then
					return
				end

				if vim.treesitter.language.add(ts_lang) then
					vim.treesitter.start()
				end
			end,
		})
	end,
	config = function()
		require("nvim-treesitter").install({
			-- data
			"xml",
			"json",
			"ini",
			"toml",
			"yaml",
			-- git
			"diff",
			"gitcommit",
			"git_rebase",
			"git_config",
			"gitignore",
			"gitattributes",
			-- markup
			"markdown",
			"rst",
			-- tool
			"make",
			"cmake",
			"ninja",
			"regex",
			"vim",
			"vimdoc",
			-- shell
			"bash",
			"fish",
			"nu",
			"powershell",
			-- programming lanuage
			"c",
			"cpp",
			"c_sharp",
			"java",
			"kotlin",
			"rust",
			"zig",
			"odin",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"nim",
			"nim_format_string",
			"crystal",
			"commonlisp",
			"python",
			"ruby",
			"julia",
			"lua",
			"fennel",
			"gdscript",
			-- web dev
			"html",
			"css",
			"scss",
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
