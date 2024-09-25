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
  nested_syntaxes = { python = 'python', ['c++'] = 'cpp' },
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vimwiki", "wiki" },
  callback = function()
    -- Set the keybindings for the buffer
    vim.keymap.set('i', 'uuu', 'ü', { buffer = true })
    vim.keymap.set('i', 'ooo', 'ö', { buffer = true })
    vim.keymap.set('i', 'aaa', 'ä', { buffer = true })
    vim.keymap.set('i', 'sss', 'ß', { buffer = true })
  end,
})
