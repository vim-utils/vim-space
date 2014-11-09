" helper functions {{{1

function! s:current_line_empty()
  return getline('.') =~# '^\s*$'
endfunction

" characterwise functions {{{1

function! s:on_leading_whitespace()
  return strpart(getline('.'), 0, col('.')) =~# '^\s\+$'
endfunction

function! s:on_trailing_whitespace()
  return strpart(getline('.'), col('.')-1) =~# '^\s\+$'
endfunction

function! s:on_whitespace()
  return strpart(getline('.'), col('.')-2, 3) =~# '\s\s'
endfunction

function! s:all_whitespace()
  norm! viw
endfunction

function! s:inner_whitespace()
  call s:all_whitespace()
  norm! olo
endfunction

function! s:next_regex_in_line(regex)
  return match(getline('.'), a:regex, col('.')-1) + 1
endfunction

function! s:inner_characterwise()
  if s:on_leading_whitespace() || s:on_trailing_whitespace()
    call s:all_whitespace()
  elseif s:on_whitespace()
    call s:inner_whitespace()
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
  if s:on_leading_whitespace() || s:on_trailing_whitespace() || s:on_whitespace()
    call s:all_whitespace()
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

function! s:on_leading_blank_lines()
  return ! search('\S', 'bnW')
endfunction

function! s:on_trailing_blank_lines()
  return ! search('\S', 'nW')
endfunction

function! s:on_blank_line()
  return search('^\s*$', 'nW', line('.')+1) || search('^\s*$', 'bnW', line('.')-1)
endfunction

function! s:all_blank_lines()
  norm! Vip
endfunction

function! s:inner_blank_lines()
  call s:all_blank_lines()
  norm! ojo
endfunction

function! s:inner_linewise()
  if s:on_leading_blank_lines() || s:on_trailing_blank_lines()
    call s:all_blank_lines()
  elseif s:on_blank_line()
    call s:inner_blank_lines()
  endif
endfunction

function! s:around_linewise()
  call s:all_blank_lines()
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
