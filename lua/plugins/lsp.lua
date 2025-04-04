return {
	-- lsp
	"neovim/nvim-lspconfig",
	dependencies = {
		"Issafalcon/lsp-overloads.nvim",
		"Hoffs/omnisharp-extended-lsp.nvim",
	},
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lsp_conf = require("lspconfig")
		local lsp_util = lsp_conf.util

		-- setup blink-cmp
		lsp_util.default_config.capabilities = require("blink.cmp").get_lsp_capabilities()

		-- setup default config
		lsp_util.default_config.on_attach = function(client, bufnr)
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

		lsp_conf.jsonls.setup({})

		lsp_conf.html.setup({})

		lsp_conf.cssls.setup({})

		lsp_conf.eslint.setup({})

		lsp_conf.nushell.setup({})

		lsp_conf.lua_ls.setup({
			settings = {
				Lua = {
					telemetry = {
						enable = false,
					},
				},
			},
		})

		lsp_conf.pyright.setup({})

		lsp_conf.gdscript.setup({})

		lsp_conf.clangd.setup({
			cmd = {
				"clangd",
				"--background-index",
				"--header-insertion=never",
				"--clang-tidy",
				"--experimental-modules-support",
			},
		})

		lsp_conf.omnisharp.setup({
			on_attach = function(client, bufnr)
				lsp_util.default_config.on_attach(client, bufnr)

				vim.keymap.set("n", "<f12>", function()
					require("omnisharp_extended").telescope_lsp_definition()
				end, { buffer = bufnr })
			end,
			cmd = { vim.env.HOME .. "\\apps\\omnisharp\\OmniSharp.exe" },
		})

		lsp_conf.rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {
					diagnostics = {
						enable = false,
					},
				},
			},
		})

		lsp_conf.gopls.setup({
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

		lsp_conf.nim_langserver.setup({
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
							projectFile = "main.nim",
							fileRegex = ".*\\.nim",
						},
					},
				},
			},
		})

		lsp_conf.zls.setup({})

		lsp_conf.ols.setup({})

		lsp_conf.ts_ls.setup({
			root_dir = function(filename, _)
				local is_deno_project = lsp_util.root_pattern("deno.json", "deno.jsonc")(filename)
				if is_deno_project then
					return nil
				end
				return lsp_util.root_pattern("package.json")(filename)
			end,
			single_file_support = false,
		})

		lsp_conf.denols.setup({
			settings = {
				deno = {
					enable = true,
					lint = true,
				},
			},
			root_dir = lsp_util.root_pattern("deno.json", "deno.jsonc"),
		})

		lsp_conf.astro.setup({})

		lsp_conf.svelte.setup({})

		lsp_conf.glsl_analyzer.setup({})
	end,
}
