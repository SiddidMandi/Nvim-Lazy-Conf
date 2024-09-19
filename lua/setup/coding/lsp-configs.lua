local lspconfig = require("lspconfig")
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",  -- You can choose from 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
})

-- Customize hover window appearance (optional)
vim.api.nvim_set_hl(0, "LspHoverBorder", { fg = "#A9A1E1" }) -- Border color

-- You can further enhance the appearance with padding or other options
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = {
        { "╭", "LspHoverBorder" },
        { "─", "LspHoverBorder" },
        { "╮", "LspHoverBorder" },
        { "│", "LspHoverBorder" },
        { "╯", "LspHoverBorder" },
        { "─", "LspHoverBorder" },
        { "╰", "LspHoverBorder" },
        { "│", "LspHoverBorder" }
    },
    -- Optionally add padding
    max_width = 80,
    max_height = 20,
})

local on_attach = function(client, bufnr)
	-- Key mappings
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
end
local opts = {noremap = true, silent = true}
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

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
