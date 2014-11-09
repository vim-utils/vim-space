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

### Installation

* Vundle<br/>
  `Plugin 'bruno-/vim-space'`

* Pathogen<br/>
  `git clone git://github.com/bruno-/vim-space.git ~/.vim/bundle/vim-space`

### License

[MIT](LICENSE.md)
