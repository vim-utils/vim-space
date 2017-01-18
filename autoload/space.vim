" helper functions {{{1

function! s:current_line_empty()
  return getline('.') =~# '^\s*$'
endfunction

" characterwise functions {{{1

function! s:on_leading_or_trailing_whitespace()
  return strpart(getline('.'), 0, col('.')) =~# '^\s\+$' ||
       \ strpart(getline('.'), col('.')-1) =~# '^\s*$'
endfunction

function! s:on_whitespace()
  return strpart(getline('.'), col('.')-2, 3) =~# '\s\s'
endfunction

function! s:select_whitespace(...)
  norm! viw
  if a:0 && a:1 ==# 'inner'
    norm! olo
  endif
endfunction

function! s:next_regex_in_line(regex)
  return match(getline('.'), a:regex, col('.')-1) + 1
endfunction

function! s:inner_characterwise()
  if s:on_leading_or_trailing_whitespace()
    call s:select_whitespace('all')
  elseif s:on_whitespace()
    call s:select_whitespace('inner')
  else " not positioned on whitespace
    let next_multiple_spaces = s:next_regex_in_line('\s\s')
    if next_multiple_spaces
      " moving to the next space char
      call cursor(line('.'), next_multiple_spaces)
      call s:inner_characterwise()
    endif
  endif
endfunction

function! s:around_characterwise()
  if s:on_leading_or_trailing_whitespace() || s:on_whitespace()
    call s:select_whitespace('all')
  else " not positioned on whitespace
    let next_multiple_spaces = s:next_regex_in_line('\s\s')
    if next_multiple_spaces
      " moving to the next space char
      call cursor(line('.'), next_multiple_spaces)
      call s:around_characterwise()
    endif
  endif
endfunction

" linewise functions {{{1

function! s:on_leading_or_trailing_blank_lines()
  return (! search('\S', 'bnW')) || (! search('\S', 'nW'))
endfunction

function! s:on_blank_line()
  return search('^\s*$', 'nW', line('.')+1) || search('^\s*$', 'bnW', line('.')-1)
endfunction

function! s:select_blank_lines(...)
  norm! vip
  if a:0 && a:1 ==# 'inner'
    norm! ojo
  endif
endfunction

function! s:inner_linewise()
  if s:on_leading_or_trailing_blank_lines()
    call s:select_blank_lines('all')
  elseif s:on_blank_line()
    call s:select_blank_lines('inner')
  endif
endfunction

function! s:around_linewise()
  call s:select_blank_lines('all')
endfunction

" public functions {{{1

function! space#inner()
  norm! m`
  if s:current_line_empty()
    call s:inner_linewise()
  else
    call s:inner_characterwise()
  endif
endfunction

function! space#around()
  norm! m`
  if s:current_line_empty()
    call s:around_linewise()
  else
    call s:around_characterwise()
  endif
endfunction
