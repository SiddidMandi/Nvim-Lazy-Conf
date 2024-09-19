
--require('/setup/airline')

--[[
if vim.g.loaded_vimtex then
  require('/setup/vimtex')
end
]]
--[[
if not package.loaded["vimtex"] then
  require("/setup/vimtex")
end
]]
--vim.cmd[[ autocmd FileType tex lua require('/setup/vimtex') ]]
--vim.cmd[[ autocmd FileType sql lua require('/setup/DBsql') ]]
-- vim.cmd[[ autocmd FileType java TSEnable highlight ]]
--load the vimtex module for tex files only, i.e. the only filetype the plugin
--loads up for

--require('/setup/cocConfig')
--require('/setup/oceanicNext')
require('/setup/indentBankline')
require('/setup/execution')
--require('/setup/limeLight')
--require('/setup/vimwiki')

