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

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
