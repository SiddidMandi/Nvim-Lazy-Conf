local null_ls = require("null-ls")
require("mason").setup({ install_root_dir = vim.fn.stdpath("config") .. "/Mason" })
--require("mason").setup()
-- Configure null-ls

require("mason-null-ls").setup({
	ensure_installed = { "eslint_d" },
	automatic_installation = true,
})
null_ls.setup({
	sources = {
		require("none-ls.diagnostics.eslint_d"),
		-- Formatters
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,

		---- Linters
		--null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.selene,

		--null_ls.builtins.diagnostics.eslint_d.with({ filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }, }),

		-- Other sources
		--null_ls.builtins.completion.spell,
	},
})

-- Keybinding for formatting with <leader>f
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

local function format_visual_selection()
	-- Get the visual selection range
	local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
	local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))

	-- If no lines are selected, return
	if start_line == end_line and start_col == end_col then
		print("No visual selection to format.")
		return
	end

	-- Format the selected range
	vim.lsp.buf.format({
		async = true,
		range = {
			{ start_line, start_col },
			{ end_line,   end_col },
		},
	})
end

vim.keymap.set("v", "<leader>gf", format_visual_selection, {})

