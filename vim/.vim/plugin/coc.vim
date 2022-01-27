" Global extensions across devices
let g:coc_global_extensions = [
  \'coc-css',
  \'coc-eslint',
  \'coc-html',
  \'coc-json',
  \'coc-markdownlint',
  \'coc-pairs',
  \'coc-pyright',
  \'coc-rust-analyzer',
  \'coc-snippets',
  \'coc-solargraph',
  \'coc-toml',
  \'coc-tsserver'
  \]

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Apply code action to selected code
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
