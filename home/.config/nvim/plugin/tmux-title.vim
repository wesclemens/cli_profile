if !empty($TMUX)

  " Check if automatic-rename is enabled
  if !(system("tmux show-options -w automatic-rename") =~ "off")
    " Enable this again on exit
    autocmd VimLeave * silent !tmux set-window-option automatic-rename on
    autocmd VimLeave * silent !tmux refresh-client

    "Allow vim to set window title
    if &term =~ 'screen'
      exe "set title titlestring=vim:%t"
      exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
    endif
  endif
endif
