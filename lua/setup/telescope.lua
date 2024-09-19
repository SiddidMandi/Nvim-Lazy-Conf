local opts1 = { noremap = true, silent = true }
local builtin=require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, opts1)
vim.keymap.set('n', '<leader>ps', builtin.live_grep, opts1)

vim.api.nvim_create_autocmd({"User"}, {
  pattern = {"TelescopePreviewerLoaded", "TelescopeLiveGrepPreviewerLoaded"},  -- Handle both events
  callback = function(args)
    -- Apply settings for all previews except help files
    if args.data.filetype ~= "help" then
      vim.wo.number = true
      vim.wo.wrap = true
    -- Apply settings for CSV files
    elseif args.data.bufname:match("%.csv$") then
      vim.wo.wrap = true
    end
  end,
})


local builtin=require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, opts1)
vim.keymap.set('n', '<leader>ps', builtin.live_grep, opts1)
