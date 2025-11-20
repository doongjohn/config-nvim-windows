-- semantic highlighting: https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "config",
	callback = function()
		vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "@variable" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.function.readonly", { link = "@function" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.method.readonly", { link = "@function.method" })
		vim.api.nvim_set_hl(0, "@lsp.type.builtin.zig", { link = "@type.builtin" })
		vim.api.nvim_set_hl(0, "@lsp.type.keywordLiteral.zig", { link = "@keyword" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.variable.static.zig", { link = "@variable" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.namespace.readonly.odin", { link = "@module" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.type.readonly.odin", { link = "@type" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.enum.readonly.odin", { link = "@type" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.struct.readonly.odin", { link = "@type" })
		vim.api.nvim_set_hl(0, "@lsp.type.modifier.java", { link = "@keyword" })
		vim.api.nvim_set_hl(0, "@lsp.typemod.class.readonly.java", { link = "@type" })
	end,
})

-- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316?permalink_comment_id=4534819#dealing-with-ambiguity
vim.api.nvim_create_autocmd("LspTokenUpdate", {
	group = "config",
	callback = function(args)
		local token = args.data.token

		if token.type == "method" then
			if token.modifiers.defaultLibrary then
				vim.lsp.semantic_tokens.highlight_token(
					token,
					args.buf,
					args.data.client_id,
					"@lsp.typemod.method.defaultLibrary"
				)
			end
		end
	end,
})
