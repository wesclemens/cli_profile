# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

# alias for homeshick
if [[ -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
  source $HOME/.homesick/repos/homeshick/homeshick.sh
else
  echo "Homeshick is not installed something is wrong?!?!"
fi
