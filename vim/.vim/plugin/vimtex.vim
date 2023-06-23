let g:tex_flavor='latex'
if has('win32')
    let g:vimtex_view_method='general'
else
    if system("uname -s") =~ "Darwin"
        let g:vimtex_view_method='skim'
    else
        let g:vimtex_view_method='zathura'
    endif
endif
let g:vimtex_quickfix_mode=0
autocmd BufEnter *.tex set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \    '-shell-escape',
    \    '-verbose',
    \    '-file-line-error',
    \    '-synctex=1',
    \    '-interaction=nonstopmode',
    \ ],
    \}
