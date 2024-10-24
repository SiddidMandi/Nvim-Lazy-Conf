local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	-- Key mappings
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
end

-- Configure individual LSP servers
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

lspconfig.ts_ls.setup({
	on_attach = on_attach,
})

lspconfig.pyright.setup({
	on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
})
