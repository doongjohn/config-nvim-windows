return {
	"romus204/tree-sitter-manager.nvim",
	lazy = false,
	config = function()
		require("tree-sitter-manager").setup({
			ensure_installed = {
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
			},
		})
	end,
}
