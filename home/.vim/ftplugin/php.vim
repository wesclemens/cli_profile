set expandtab
set autoindent
set colorcolumn=80,120

let g:php_folding=1
let g:noShortTags=1

" Set Tab Stops
set shiftwidth=4
if (version < 704)
  set softtabstop=4
endif

" For some reason PHP syntax file seems to be to much for vim
syntax sync minlines=256
