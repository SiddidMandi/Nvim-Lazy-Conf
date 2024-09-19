-- Setup nvim-cmp
--local luasnip = require("luasnip")

-- snippet paths and custom snippets
vim.opt.runtimepath:append("~/.config/nvim/snippets/Ultisnips")
vim.opt.runtimepath:append("~/.config/nvim/snippets/mycoolsnippets")
vim.cmd[[
let g:UltiSnipsSnippetDirectories=[ $HOME."/.config/nvim/snippets/UltiSnips", $HOME."/.config/nvim/snippets/mycoolsnippets"]
]]

require("cmp_nvim_ultisnips").setup{}
local cmp = require('cmp')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
--require('mason').setup({ install_root_dir = vim.fn.stdpath('config') .. '/Mason', })

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  sources = {
    { name = "ultisnips" },
	{ name = "path" },
	{ name = "nvim_lsp" },
	{ name = "vimtex" },
	--{ name = "digraphs" }
	--{ name = "luasnip" }
    -- You can add more completion sources here
  },
  mapping = {
	--["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	 ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    --["<C-p>"] = cmp.mapping( cmp_ultisnips_mappings.select_prev_item, { "i", "s" }),
	["<C-f>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
    --["<C-n>"] = cmp.mapping( cmp_ultisnips_mappings.select_next_item, { "i", "s" }),
    ["<c-j>"] = cmp.mapping( cmp_ultisnips_mappings.jump_forwards, { "i", "s"}),
    ["<c-d>"] = cmp.mapping( cmp_ultisnips_mappings.jump_backwards, { "i", "s" }),
    --["<C-f>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, })
  },
})

