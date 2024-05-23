if exists(":Tabularize")
  nmap <leader>a= :call Tabularize("/=")<CR>
  vmap <leader>a= :call Tabularize("/=")<CR>
  nmap <leader>a# :call Tabularize("/#")<CR>
  vmap <leader>a# :call Tabularize("/#")<CR>
  nmap <leader>a: :call Tabularize("/:")<CR>
  vmap <leader>a: :call Tabularize("/:")<CR>
  nmap <leader>a" :call Tabularize("/\"")<CR>
  vmap <leader>a" :call Tabularize("/\"")<CR>
endif
