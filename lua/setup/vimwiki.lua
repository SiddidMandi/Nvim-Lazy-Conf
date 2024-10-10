local opts1 = { noremap = true, silent = true }

-- Key mappings for custom list symbols
vim.keymap.set('n', '\\w', 'i✗', opts1)
vim.keymap.set('n', '\\r', 'i✓', opts1)

-- Disable table mappings for vimwiki
vim.g.vimwiki_table_mappings = 0

-- Set custom todo list symbols
vim.g.vimwiki_listsyms = '✗○◐●✓'

-- Define the wiki list
local wiki_1 = {
  path = '~/Documents/vimwiki/wiki_Personal',
  nested_syntaxes = { python = 'python', ['c++'] = 'cpp', sh = 'bash' },
  listyms = '✗○◐●✓',
}

local wiki_2 = {
  path = '~/Documents/vimwiki/wiki_Academic',
  nested_syntaxes = { python = 'python', ['c++'] = 'cpp', java = 'java', javascript = 'javascript' },
}

local wiki_3 = {
  path = '~/Documents/vimwiki/wiki_tech',
  nested_syntaxes = { python = 'python', ['c++'] = 'cpp', java = 'java', javascript = 'javascript', bash = 'bash' },
}

local wiki_4 = { path = '~/Documents/vimwiki/languages' }
local wiki_5 = { path = '~/Documents/vimwiki/wiki_encyclopedia' }
local wiki_6 = { path = '~/Documents/vimwiki/wiki_work' }

vim.g.vimwiki_list = { wiki_1, wiki_2, wiki_3, wiki_4, wiki_5, wiki_6 }

-- Autocommand to unmap <Tab> for Vimwiki
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'vimwiki',
  command = 'silent! iunmap <buffer> <Tab>',
})

-- Create key binding for VimwikiTable
vim.keymap.set('n', '<leader>t', ':VimwikiTable<CR>', { noremap = true, silent = true })

-- Define autocmds for special characters in the 'languages' wiki

-- Define autocmds for special characters in the 'languages' wiki
local wiki_group = vim.api.nvim_create_augroup("WikiBindings", { clear = true })

-- Define a function to set the keymaps
local function set_wiki_keymaps()
    local opts = { buffer = true }
    vim.keymap.set('i', 'uuu', 'ü', opts)
    vim.keymap.set('i', 'ooo', 'ö', opts)
    vim.keymap.set('i', 'aaa', 'ä', opts)
    vim.keymap.set('i', 'sss', 'ß', opts)
end

-- Create an autocmd that triggers on entering any *.wiki file in the specified directory
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = vim.fn.expand("$HOME") .. "/Documents/vimwiki/languages/*.wiki",
    callback = set_wiki_keymaps,
    group = wiki_group,
})
