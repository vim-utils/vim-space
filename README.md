# space.vim

Vim text objects for the whitespace.

### Text objects

* `a<Space>` "around whitespace", selects all the whitespace characters around
  the cursor.<br/>
  When invoked on an empty line, operator behaves
  [linewise](http://vimdoc.sourceforge.net/htmldoc/motion.html#linewise) by
  selecting all the surrounding empty lines.
* `i<Space>` "inner whitespace", selects all the whitespace characters around
  the cursor, except the first char.<br/>
  When invoked on an empty line, operator behaves
  [linewise](http://vimdoc.sourceforge.net/htmldoc/motion.html#linewise) by
  selecting all the surrounding empty lines, except the first one.

### Why?

The most common use would be to easily get rid of the excessive whitespace.

### Options

To disable default mappings, add the following to vimrc:

```viml
let g:space_default_mappings = 0
```

Example creating custom mappings for `i<Ctrl-s>` and `a<Ctrl-s>`:

```viml
omap <silent> i<C-s> <Plug>(inner_space)
xmap <silent> i<C-s> <Plug>(inner_space)
omap <silent> a<C-s> <Plug>(around_space)
xmap <silent> a<C-s> <Plug>(around_space)
```

Also, you might find these single-key mappings useful:

```viml
omap <silent> <Space> <Plug>(inner_space)
xmap <silent> <Space> <Plug>(inner_space)
```

### Installation

* Vundle<br/>
  `Plugin 'bruno-/vim-space'`

* Pathogen<br/>
  `git clone git://github.com/bruno-/vim-space.git ~/.vim/bundle/vim-space`

### License

[MIT](LICENSE.md)
