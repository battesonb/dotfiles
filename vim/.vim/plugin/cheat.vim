function! s:cheat(...)
  execute ':tabnew | term curl --silent cheat.sh/'.join(a:000, '+')
endfunction

command! -nargs=+ -complete=command Cht call s:cheat(<f-args>)
