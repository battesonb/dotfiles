" use faster searching methods if they are available
if isdirectory('./.git')
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --others --exclude-standard']
elseif executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
elseif executable('ag')
  let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
endif
