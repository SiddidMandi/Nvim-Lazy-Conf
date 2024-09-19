

--
vim.cmd[[
autocmd filetype vimwiki silent! iunmap <buffer> <Tab>

autocmd filetype python nnoremap <leader>e :!python %
autocmd filetype vimwiki silent! iunmap +
"autocmd filetype vimwiki silent! iunmap <buffer> +
"nnoremap! + <NOP>

"au filetype vimwiki silent! iunmap <buffer> <S-Tab>
]]  

--autocmd and au are the same
--this autocmd only applies to vimwiki extension
--and is fired when a filetype with that extensio is loaded up and only applie
--to the current buffer
--Since it only applies to vimwiki ext, then it only unmaps that function and
--doesn't touch vim ones.
--]]
