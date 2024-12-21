return {
	-- lsp
	"neovim/nvim-lspconfig",
	dependencies = {
		"smiteshp/nvim-navic",
		"Issafalcon/lsp-overloads.nvim",
	},
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lsp = require("lspconfig")

		-- lsp.util.default_config.capabilities =
		-- 	require("blink.cmp").get_lsp_capabilities(lsp.util.default_config.capabilities)
		lsp.util.default_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

		lsp.util.default_config.on_attach = function(client, bufnr)
			-- lsp breadcrumbs
			if client.server_capabilities.documentSymbolProvider then
				require("nvim-navic").attach(client, bufnr)
			end

			-- view overloads
			if client.server_capabilities.signatureHelpProvider then
				---@diagnostic disable-next-line: missing-fields
				require("lsp-overloads").setup(client, {
					---@diagnostic disable-next-line: missing-fields
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
			end
		end

		-- vscode-langservers-extracted
		lsp.jsonls.setup({})
		lsp.html.setup({})
		lsp.cssls.setup({})
		lsp.eslint.setup({})

		-- scripting languages
		lsp.nushell.setup({})
		lsp.lua_ls.setup({
			settings = {
				Lua = {
					telemetry = {
						enable = false,
					},
				},
			},
		})
		lsp.pyright.setup({})
		lsp.gdscript.setup({})

		-- compiled languages
		lsp.clangd.setup({
			cmd = {
				"clangd",
				"--background-index",
				"--header-insertion=never",
				"--clang-tidy",
				"--experimental-modules-support",
			},
		})
		lsp.rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {
					diagnostics = {
						enable = false,
					},
				},
			},
		})
		lsp.gopls.setup({
			on_attach = function(client, bufnr)
				lsp.util.default_config.on_attach(client, bufnr)

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
		lsp.nim_langserver.setup({
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
		lsp.zls.setup({
			cmd = { "zigscient" },
		})
		lsp.ols.setup({})

		-- web dev
		lsp.ts_ls.setup({
			root_dir = function(filename, _)
				local is_deno_project = lsp.util.root_pattern("deno.json", "deno.jsonc")(filename)
				if is_deno_project then
					return nil
				end
				return lsp.util.root_pattern("package.json")(filename)
			end,
			single_file_support = false,
		})
		lsp.denols.setup({
			settings = {
				deno = {
					enable = true,
					lint = true,
				},
			},
			root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
		})
		lsp.astro.setup({})
		lsp.svelte.setup({})

		-- shader langauges
		lsp.glsl_analyzer.setup({})
	end,
}
