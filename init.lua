vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local highlights = {
			"Normal",
			"LineNr",
			"Folded",
			"NonText",
			"SpecialKey",
			"VertSplit",
			"SignColumn",
			"EndOfBuffer",
			"TablineFill",
		}
		for _, name in pairs(highlights) do
			vim.cmd.highlight(name .. " guibg=none ctermbg=none")
		end
	end,
})
--formatting = stylua
vim.o.colorscheme = OceanicNext

vim.cmd([[au BufRead,BufNewFile *.wiki set filetype=vimwiki]])

--local lazypath = vim.fn.stdpath("config") .. "/lazyPlugs/lazy.nvim"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

-- Add Lazy.nvim to the runtime path
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup Lazy.nvim with plugins and custom root directory for plugins

require("lazy").setup({
	--config is after plugin is loaded, init is before
	{ dir = vim.fn.stdpath("config") .. "/pack/plugins/start/vim-devicons", lazy = false },
	{
		"mhartington/oceanic-next",
		config = function()
			vim.cmd([[colorscheme OceanicNext]])
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = { theme = "nightfly" },
				sections = {
					lualine_c = { { "filename", path = 2 } },
				},
			})
		end,
	},
	-- UI enhancements
	{ "MunifTanjim/nui.nvim" },
	{ "rcarriga/nvim-notify" },
	{
		"folke/noice.nvim",
		config = function()
			require("setup/noice")
		end,
	},
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  -- end
  {
    "junegunn/vim-peekaboo",
    --"gennaro-tedesco/nvim-peekup",
  },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = { "<leader>n" },
		config = function()
      require("setup/neo-tree")
		end,
	},

	{
		"vimwiki/vimwiki",
		branch = "dev",
		ft = { "vimwiki", "markdown", "wiki" },
		init = function()
			require("setup/vimwiki")
		end,
	},
	{ "jalvesaq/Nvim-R",      ft = { "R", "r" } },
	{
		"lervag/vimtex",
		ft = { "tex" },
		config = function()
			require("setup/vimtex")
		end,
	},

	-- Treesitter
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		commit = "927c10f748e49c543b2d544c321a1245302ff324",
		tag = "0.1.8", -- Optional: Ensure this tag is compatible or remove if using commit
		--keys = { "<leader>pf" },
		config = function()
			require("setup/telescope")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		keys = { "<leader>jj", "<leader>ja" },
		config = function()
			require("setup/harpoon")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			ensure_installed = "all", -- Ensures all parsers are installed
		},
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("setup/all-cmp")
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp",                event = "InsertEnter" },
	{ "hrsh7th/cmp-buffer",                  event = "InsertEnter" },
	{ "hrsh7th/cmp-path",                    event = "InsertEnter" },
	{ "hrsh7th/cmp-cmdline",                 event = "InsertEnter" },
	{ "micangl/cmp-vimtex",                  ft = "tex",           event = "InsertEnter" },
	{ "f3fora/cmp-spell",                    ft = "tex",           event = "InsertEnter" },

	-- Snippets
	{ "SirVer/ultisnips",                    event = "InsertEnter" },
	{ "quangnguyen30192/cmp-nvim-ultisnips", event = "InsertEnter" },

	--code editing
	{
		"williamboman/mason-lspconfig.nvim", --needed
		--exclude = { "wiki", "vimwiki", "markdown" },
	},
	{
		"williamboman/mason.nvim",
		exclude = { "viki", "vimwiki", "markdown" },
		opts = { install_root_dir = vim.fn.stdpath("config") .. "/Mason" }, -- for default directory
		-- opts = {} -- for default directory, opts does require("plugin").setup(opts)
	},
	{
		"neovim/nvim-lspconfig",
		--lazy = { false },
		--event = "InsertEnter",
		exclude = { "wiki", "vimwiki", "markdown" },
		config = function()
			--require("setup/lsp-configs")
			require("setup/coding/lsp-configs")
		end,
	},

	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			require("setup/coding/null-ls")
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	{ "tpope/vim-fugitive" },
}, {
	--root = vim.fn.stdpath("config") .. "/lazyPlugs", -- Custom directory for plugins
	root = vim.fn.stdpath("data") .. "/lazyPlugs", -- .local
})

vim.cmd([[
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number
set scrolloff=3
set nobackup
set mouse=a
set foldcolumn=0
set signcolumn=no
set winheight=20
set encoding=utf8
set ignorecase
set relativenumber
"set autochdir "this messes with harpoon

"keepin tabs
"set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set encoding=UTF-8
set textwidth=75 "let g:coc_node_path_warning=0
]])
vim.o.syntax = "true"
vim.o.number = true
--vim.api.nvim_set_option("clipboard","unnamed")
vim.opt.clipboard = "unnamed,unnamedplus"
vim.o.splitbelow = true

--vim.opt.list = true
--vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"

-- Calcurse option thingy, custom filetype and syntax
vim.cmd([[
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=vimwiki
autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=vimwiki
]])
-------------------------------------END OF OPTIONS-------------------

--require('myMappings') -- for mappings
vim.cmd([[nnoremap <space> <Nop>]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.api.nvim_set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kj", "<ESC>", { noremap = true, silent = true })
--vim.opt[guicursor] = ""
-- USE ctrl + [

local mapper = vim.api.nvim_set_keymap
local opts1 = { noremap = true, silent = true }
mapper("n", ";", ":", opts1)
mapper("n", "+", ":res +2<CR>", opts1)
mapper("n", "_", ":res -2<CR>", opts1)
mapper("n", "-", ":vertical resize -2<CR>", opts1)
mapper("n", "=", ":vertical resize +2<CR>", opts1)
mapper("n", "<C-s>", "<C-6>", opts1)
mapper("i", "<C-s>", "<C-6>", opts1)
mapper("n", "x", '"_x', opts1) --if this no work see below -idk how to do
mapper("x", "x", '"_x', opts1)
mapper("n", "dw", 'b"_dw', opts1)
mapper("n", "daw", 'b"_dw', opts1)
mapper("v", "<S-i>", "^", opts1)   -- stay in normal mode ok for visual
mapper("v", "<S-a>", "$", opts1)   -- stay in normal mode
mapper("v", "<S-Y>", '"+y', opts1) -- stay in normal mode

vim.cmd([[
  autocmd FileType vimwiki setlocal tabstop=8
  autocmd FileType vimwiki setlocal shiftwidth=8
  autocmd FileType vimwiki setlocal softtabstop=8
]])

vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = function()
		local last_cmd = vim.fn.getcmdline()
		--local filetype = vim.bo.filetype
		local cmd_type = vim.fn.getcmdtype()
		--print(cmd_type)

		if cmd_type == ":" and (last_cmd == "G" or last_cmd == "G log") then
			local new_cmd = "vertical " .. last_cmd
			print("making vert", last_cmd)
			vim.fn.setcmdline(new_cmd)
		end
	end,
})
vim.cmd([[
hi Search ctermfg=cyan ctermbg=black guibg=darkblue guifg=#ffffff gui=bold
hi CurSearch ctermfg=cyan guibg=darkblue guifg=#ffffff gui=bold
hi IncSearch ctermfg=cyan guibg=darkblue guifg=#ffffff gui=bold
hi SpellBad ctermbg=red guibg=red
]])
-- Set Git diff highlights to nothing (clears the colors)
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "none", fg = "none" })    -- Clears added lines highlight
vim.api.nvim_set_hl(0, "DiffChange", { bg = "none", fg = "none" }) -- Clears changed lines highlight
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "none", fg = "none" }) -- Clears deleted lines highlight
vim.api.nvim_set_hl(0, "DiffText", { bg = "none", fg = "none" })   -- Clears the highlight for text changes within a line

vim.opt.spelllang = { "en_us" }
vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = function()
		local last_cmd = vim.fn.getcmdline()
		--local filetype = vim.bo.filetype
		local cmd_type = vim.fn.getcmdtype()
		--print(cmd_type)

		if cmd_type == ":" and (last_cmd == "G" or last_cmd == "G log") then
			local new_cmd = "vertical " .. last_cmd
			print("making vert", last_cmd)
			vim.fn.setcmdline(new_cmd)
		end
	end,
})
