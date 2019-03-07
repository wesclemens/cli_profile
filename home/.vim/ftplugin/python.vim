" Set python as the make program and
if filereadable("setup.py")
  setlocal makeprg=python\ setup.py\ build
else
  setlocal makeprg=python\ -m\ py_compile\ %
  setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
endif

set foldmethod=syntax
set expandtab
set autoindent
set colorcolumn=100,80,73

" Set Tab Stops
set shiftwidth=4
if (version < 704)
  set softtabstop=4
endif
