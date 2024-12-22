if has('win32')
    set runtimepath^=~/vimfiles runtimepath+=~/vimfiles/after
    let &packpath=&runtimepath
    source ~/vimfiles/vimrc
else
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath=&runtimepath
    source ~/.vim/vimrc
endif

lua require('luainit')
