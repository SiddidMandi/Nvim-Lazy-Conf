--harpoon
local mapper = vim.api.nvim_set_keymap
local opts1 = { noremap = true, silent = true }
mapper('n','<c-S-N>',':bnext<CR>', opts1) -- for section view
mapper('n','<c-S-P>',':bprev<CR>', opts1) -- for section view
mapper('n','<leader>jw',':bwipe<CR>', opts1) -- for section view
mapper('n','<leader>ja',':lua require("harpoon.mark").add_file()<CR>', opts1) -- for section view
mapper('n','<leader>jj',':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts1) -- for section view
