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

		vim.lsp.config("avalonia_ls", {
			cmd = { "AvaloniaLanguageServer.cmd" },
			filetypes = { "axaml" },
			root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				on_dir(lsp_util.root_pattern("*.sln", "*.slnx", "*.csproj")(fname))
			end,
			workspace_required = true,
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

		vim.lsp.config("ols", {
			init_options = {
				odin_command = "odin.cmd",
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
			root_dir = function(bufnr, on_dir)
				local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
				local project_root = vim.fs.root(bufnr, root_markers)
				on_dir(project_root)
			end,
			workspace_required = true,
		})

		vim.lsp.config("denols", {
			root_markers = { "deno.json", "deno.jsonc" },
			workspace_required = true,
		})

		-- NOTE: goto definition issue: https://github.com/denoland/deno/issues/28794
		vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
			pattern = { "deno:/*" },
			callback = function(params)
				local bufnr = params.buf
				local actual_path = params.match:sub(1)

				local clients = vim.lsp.get_clients({ name = "denols" })
				if #clients == 0 then
					return
				end

				local client = clients[1]
				local method = "deno/virtualTextDocument"
				local req_params = { textDocument = { uri = actual_path } }
				local response = client:request_sync(method, req_params, 2000, 0)
				if not response or type(response.result) ~= "string" then
					return
				end

				local lines = vim.split(response.result, "\n")
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
				vim.api.nvim_set_option_value("readonly", true, { buf = bufnr })
				vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
				vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
				vim.api.nvim_buf_set_name(bufnr, actual_path)
				vim.lsp.buf_attach_client(bufnr, client.id)

				local filetype = "typescript"
				if actual_path:sub(-3) == ".md" then
					filetype = "markdown"
				end
				vim.api.nvim_set_option_value("filetype", filetype, { buf = bufnr })
			end,
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
			"nushell",
			"lua_ls",
			"pyright",
			"gdscript",

			"clangd",
			"rust_analyzer",
			"avalonia_ls",
			"gopls",
			"nim_langserver",
			"zls",
			"ols",

			"lemminx",

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
