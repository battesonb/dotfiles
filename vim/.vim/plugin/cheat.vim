let s:languages = [
\   "bash",
\   "c",
\   "cpp",
\   "go",
\   "haskell",
\   "java",
\   "javascript",
\   "js",
\   "kotlin",
\   "lisp",
\   "ocaml",
\   "perl",
\   "prolog",
\   "python",
\   "ruby",
\   "rust",
\   "scala",
\   "shell",
\   "ts",
\   "typescript",
\   "vim",
\   "zsh",
\ ]

function! s:cheat(languages, ...)
  let ft = &filetype
  let args = join(a:000, '+')
  if (empty(ft) || index(a:languages, a:1) == -1)
    let args = ft . '/' . args
  endif
  execute ':tabnew | term curl cheat.sh/' . args
endfunction

command! -nargs=+ -complete=command Cht call s:cheat(s:languages, <f-args>)
