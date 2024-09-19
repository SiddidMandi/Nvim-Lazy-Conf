local null_ls = require("null-ls")
require("mason").setup({ install_root_dir = vim.fn.stdpath("config") .. "/Mason" })
-- Configure null-ls

require("mason-null-ls").setup({
	ensure_installed = {},
	automatic_installation = false,
	handlers = {},
})
null_ls.setup({
	sources = {
		-- Formatters
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,

		---- Linters
		--null_ls.builtins.diagnostics.eslint,

		-- Other sources
		--null_ls.builtins.completion.spell,
	},
})

-- Keybinding for formatting with <leader>f
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

--vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", callback = function() vim.lsp.buf.format({ timeout_ms = 2000 }) end, })
