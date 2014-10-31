" characterwise functions {{{1

function! s:current_line_empty()
  return getline('.') =~# '^\s*$'
endfunction

function! s:positioned_on_leading_whitespace()
  return strpart(getline('.'), 0, col('.')) =~# '^\s\+$'
endfunction

function! s:positioned_on_trailing_whitespace()
  return strpart(getline('.'), col('.')-1) =~# '^\s\+$'
endfunction

function! s:positioned_on_whitespace()
  return strpart(getline('.'), col('.')-2, 3) =~# '\s\s'
endfunction

function! s:leading_whitespace()
  norm! 0vwh
endfunction

function! s:trailing_whitespace()
  norm! gelv$h
endfunction

function! s:whitespace_charwise(...)
  norm! ge
  if a:0 && a:1 ==# 'all'
    echom 'all!'
    norm! l
  else " leaving one space between words
    echom 'inner'
    norm! 2l
  endif
  norm! vwh
endfunction

function! s:next_regex_in_line(regex)
  return match(getline('.'), a:regex, col('.')-1) + 1
endfunction

function! s:inner_characterwise()
  if s:positioned_on_leading_whitespace()
    call s:leading_whitespace()

  elseif s:positioned_on_trailing_whitespace()
    call s:trailing_whitespace()

  elseif s:positioned_on_whitespace()
    call s:whitespace_charwise()

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
  if s:positioned_on_leading_whitespace()
    call s:leading_whitespace()

  elseif s:positioned_on_trailing_whitespace()
    call s:trailing_whitespace()

  elseif s:positioned_on_whitespace()
    call s:whitespace_charwise('all')

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

function! s:positioned_on_leading_blank_lines()
  return ! search('\S', 'bnW')
endfunction

function! s:positioned_on_trailing_blank_lines()
  return ! search('\S', 'nW')
endfunction

function! s:positioned_on_blank_lines()
  return search('^\s*$', 'nW', line('.')+1) || search('^\s*$', 'bnW', line('.')-1)
endfunction

function! s:leading_blank_lines()
  norm! gg0V
  if search('\S','W')
    norm! k$
  else
    " handles completely empty buffer
    norm! G$
  endif
endfunction

function! s:trailing_blank_lines()
  call search('\S','bW')
  norm! j0VG$
endfunction

function! s:blank_lines_linewise(...)
  call search('\S','bW')
  if a:0 && a:1 ==# 'all'
    norm! j
  else
    norm! 2j
  endif
  norm! 0V
  call search('\S','W')
  norm! k$
endfunction

function! s:inner_linewise()
  if s:positioned_on_leading_blank_lines()
    call s:leading_blank_lines()

  elseif s:positioned_on_trailing_blank_lines()
    call s:trailing_blank_lines()

  elseif s:positioned_on_blank_lines()
    call s:blank_lines_linewise()

  " else
    " not positioned on a blank line, handled by the characterwise function
  endif
endfunction

function! s:around_linewise()
  if s:positioned_on_leading_blank_lines()
    call s:leading_blank_lines()

  elseif s:positioned_on_trailing_blank_lines()
    call s:trailing_blank_lines()

  elseif s:positioned_on_blank_lines()
    call s:blank_lines_linewise('all')

  " else
    " not positioned on a blank line, handled by the characterwise function
  endif
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
