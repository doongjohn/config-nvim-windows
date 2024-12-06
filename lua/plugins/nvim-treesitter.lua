return {
	-- treesitter
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "UIEnter",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			sync_install = false,
			ensure_installed = {
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
				-- compiled lanuage
				"c",
				"cpp",
				"c_sharp",
				"rust",
				"zig",
				"odin",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"nim",
				"nim_format_string",
				"commonlisp",
				-- scripting lanuage
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
				-- markup
				"markdown",
				"rst",
				-- data
				"json",
				"jsonc",
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
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
				disable = {
					"cpp",
					"zig",
					"odin",
					"lua",
					"html",
					"javascript",
				},
			},
		})
	end,
}
