function! runscript#CheckForShebang()
  silent cd %:p:h
  if (match( getline(1) , '^\#!') == 0)
    !./%
  elseif (&ft == 'php')
    !php ./%
  elseif (&ft == 'javascript')
    !node ./%
  elseif (&ft == 'python')
    !python ./%
  elseif (&ft == 'java')
    silent !javac ./%
    !java %:r
  else
    echo "Could not excute script."
  end
  silent cd -
endfunction

