nnoremap <leader>m :MaximizerToggle!<CR>

fun! GotoWindow(id)
  call win_gotoid(a:id)
  MaximizerToggle
endfun
