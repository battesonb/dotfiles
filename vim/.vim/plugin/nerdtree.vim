" toggle nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>

" close vim if nerdtree is the only open window 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
