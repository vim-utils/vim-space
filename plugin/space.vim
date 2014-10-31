" ============================================================================
" File: space.vim
" Author: Bruno Sutic
" Version: 0.0.1
" WebPage: https://github.com/bruno-/vim-space
" ============================================================================

if exists('g:loaded_space') && g:loaded_space
  finish
endif
let g:loaded_space = 1

let s:save_cpo = &cpo
set cpo&vim

onoremap <silent> <Plug>(inner_space)  :<C-U>call space#inner()<CR>
xnoremap <silent> <Plug>(inner_space)  :<C-U>call space#inner()<CR>
onoremap <silent> <Plug>(around_space) :<C-U>call space#around()<CR>
xnoremap <silent> <Plug>(around_space) :<C-U>call space#around()<CR>

if get(g:, 'space_default_mappings', 1)
  omap <silent> <Space>  <Plug>(inner_space)
  xmap <silent> <Space>  <Plug>(inner_space)
  omap <silent> i<Space> <Plug>(inner_space)
  xmap <silent> i<Space> <Plug>(inner_space)
  omap <silent> a<Space> <Plug>(around_space)
  xmap <silent> a<Space> <Plug>(around_space)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
