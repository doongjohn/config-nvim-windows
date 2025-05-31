return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"Issafalcon/lsp-overloads.nvim",
		"Hoffs/omnisharp-extended-lsp.nvim",
	},
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		vim.lsp.enable({
			"nushell",
			"lua_ls",
			"pyright",
			"gdscript",

			"clangd",
			"omnisharp",
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
			"astro",
			"tailwindcss",
		})
	end,
	config = function()
		local lsp_conf = require("lspconfig")
		local lsp_util = lsp_conf.util

		lsp_util.default_config.on_attach = function(client, _)
			if client.server_capabilities.signatureHelpProvider then
				---@diagnostic disable: missing-fields
				require("lsp-overloads").setup(client, {
					ui = {
						border = "none",
					},
					keymaps = {
						next_signature = "<C-j>",
						previous_signature = "<C-k>",
						next_parameter = "<nop>",
						previous_parameter = "<nop>",
						close_signature = "<nop>",
					},
				})
				---@diagnostic enable: missing-fields
			end
		end

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

		vim.lsp.config("omnisharp", {
			on_attach = function(client, bufnr)
				lsp_util.default_config.on_attach(client, bufnr)

				vim.keymap.set("n", "<f12>", function()
					require("omnisharp_extended").lsp_definition()
				end, { buffer = bufnr })
			end,
			cmd = {
				vim.env.HOME .. "\\apps\\omnisharp\\OmniSharp.exe",
				"-z",
				"--hostPID",
				"12345",
				"DotNet:enablePackageRestore=false",
				"--encoding",
				"utf-8",
				"--languageserver",
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
					projectMapping = {
						{
							projectFile = "tests/all.nim",
							fileRegex = "tests/.*\\.nim",
						},
						{
							projectFile = "src/main.nim",
							fileRegex = ".*\\.nim",
						},
					},
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
	end,
}
