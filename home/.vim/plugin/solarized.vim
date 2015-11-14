" * solarized
" Enable syntax highlighting if we have color support
if has('syntax') && (&t_Co > 2)
  syntax enable
  let g:solarized_termcolors=256
  let s:orig_background = &background
  colorscheme solarized
  execute 'set background='.s:orig_background
  unlet s:orig_background
  " Highlight whitespace errors
  au Syntax * syn match Error /\s\+$/ | syn match Error /^\s\+$/

  " Code foldin
  set foldmethod=syntax

endif


