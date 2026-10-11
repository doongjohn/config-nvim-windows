return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		local lsp_conf = require("lspconfig")
		local lsp_util = lsp_conf.util

		lsp_util.default_config.capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.lsp.config("powershell_es", {
			bundle_path = "~/apps/powershell_es",
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					telemetry = {
						enable = false,
					},
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
						},
					},
				},
			},
		})

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--header-insertion=never",
				"--clang-tidy",
				-- "--experimental-modules-support",
			},
		})

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					diagnostics = {
						enable = false,
					},
				},
			},
		})

		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					gofumpt = true,
					staticcheck = true,
					semanticTokens = true,
				},
			},
		})

		vim.lsp.config("ols", {
			settings = {
				odin_command = "odin.cmd",
			},
		})

		vim.lsp.config("avalonia_ls", {
			cmd = { "AvaloniaLanguageServer.cmd" },
			filetypes = { "axaml" },
			root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				on_dir(lsp_util.root_pattern("*.sln", "*.slnx", "*.csproj")(fname))
			end,
			workspace_required = true,
		})

		vim.lsp.config("cssls", {
			settings = {
				css = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
				scss = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
				less = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})

		vim.lsp.config("tailwindcss", {
			root_dir = function(bufnr, on_dir)
				local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
				local project_root = vim.fs.root(bufnr, root_markers)
				on_dir(project_root)
			end,
			workspace_required = true,
		})

		vim.lsp.enable({
			"powershell_es",
			"nushell",
			"lua_ls",
			"pyrefly",
			"gdscript",

			"clangd",
			"rust_analyzer",
			"gopls",
			"zls",
			"ols",

			"avalonia_ls",
			"lemminx",

			"jsonls",
			"html",
			"cssls",
			"eslint",
			"emmet_language_server",
			"tsc",
			"svelte",
			"tailwindcss",
		})
	end,
}
