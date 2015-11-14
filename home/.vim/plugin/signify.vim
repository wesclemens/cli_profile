" * signify

if &background == 'dark'
  highlight DiffAdd cterm=bold ctermbg=DarkGrey ctermfg=119
  highlight DiffDelete cterm=bold ctermbg=DarkGrey ctermfg=167
  highlight DiffChange cterm=bold ctermbg=DarkGrey ctermfg=227
else
  highlight DiffAdd cterm=bold ctermbg=Grey ctermfg=119
  highlight DiffDelete cterm=bold ctermbg=Grey ctermfg=167
  highlight DiffChange cterm=bold ctermbg=Grey ctermfg=227
endif
