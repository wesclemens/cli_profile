" * Powerline
" load powerline
if has('python')
  python << endpython
try:
  from powerline.vim import setup as powerline_setup
  powerline_setup()
  del powerline_setup
except ImportError:
  pass
endpython
endif

" powerline settings
set noshowmode
if has("gui_macvim")
  set guifont=Menlo\ For\ Powerline
  set antialias
endif

