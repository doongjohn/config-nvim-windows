return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		local lsp_conf = require("lspconfig")
		local lsp_util = lsp_conf.util

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					telemetry = {
						enable = false,
					},
					runtime = {
						version = "LuaJIT",
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
			on_attach = function(client, bufnr)
				lsp_util.default_config.on_attach(client, bufnr)

				-- generate a synthetic semanticTokensProvider (https://github.com/golang/go/issues/54531).
				if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
					local semantic = client.config.capabilities.textDocument.semanticTokens
					client.server_capabilities.semanticTokensProvider = {
						full = true,
						legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
						range = true,
					}
				end
			end,
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

		vim.lsp.config("nim_langserver", {
			handlers = {
				["window/showMessage"] = function(_, result, _)
					local log_levels = {
						vim.log.levels.ERROR, -- Error
						vim.log.levels.WARN, -- Warning
						vim.log.levels.INFO, -- Info
						vim.log.levels.TRACE, -- Log
						vim.log.levels.DEBUG, -- Debug
					}
					vim.notify("[nim langserver]: " .. result.message, log_levels[result.type])
				end,
			},
			settings = {
				nim = {
					nimsuggestPath = "~/apps/nim/bin/nimsuggest",
				},
			},
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

		vim.lsp.config("ts_ls", {
			root_markers = { "package.json" },
			workspace_required = true,
		})

		vim.lsp.config("denols", {
			root_markers = { "deno.json", "deno.jsonc" },
			workspace_required = true,
		})

		vim.lsp.enable({
			"nushell",
			"lua_ls",
			"pyright",
			"gdscript",

			"clangd",
			"roslyn_ls",
			"rust_analyzer",
			"gopls",
			"nim_langserver",
			"zls",
			"ols",

			"jsonls",
			"html",
			"cssls",
			"eslint",

			"emmet_language_server",
			"ts_ls",
			"denols",
			"svelte",
			"tailwindcss",
		})
	end,
}
