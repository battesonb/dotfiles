function! LightlineCocStatus()
    return get(g:, 'coc_status', '')
endfunction

let s:indicator_warnings = get(g:, 'lightline_indicator_warnings', '•')
let s:indicator_errors = get(g:, 'lightline_indicator_errors', '×')

function! LightlineCocErrors()
    if s:isHidden()
        return ''
    endif
    let l:counts = s:count('error')
    return l:counts == 0 ? '' : printf(s:indicator_errors . '%d', l:counts)
endfunction

function! LightlineCocWarns()
    if s:isHidden()
        return ''
    endif
    let l:counts = s:count('warning')
    return l:counts == 0 ? '' : printf(s:indicator_warnings . '%d', l:counts)
endfunction

let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste', ],
  \             [ 'readonly', 'filename', 'modified', 'coc_errors', 'coc_warns', 'coc_status' ] ]
  \ },
  \ 'component_expand': {
  \   'coc_errors': 'LightlineCocErrors',
  \   'coc_warns': 'LightlineCocWarns'
  \ },
  \ 'component_function': {
  \   'coc_status': 'LightlineCocStatus'
  \ },
  \ 'component_type': {
  \   'coc_errors': 'error',
  \   'coc_warns': 'warning'
  \ }
  \ }


function! s:count(level) abort
  let info = get(b:, 'coc_diagnostic_info', {})
    return get(info, a:level, 0)
endfunction

function! s:isHidden()
  return exists('*lightline#sensible#isHidden') && lightline#sensible#isHidden()
endfunction

autocmd User CocStatusChange call lightline#update()
autocmd User CocDiagnosticChange call lightline#update()
