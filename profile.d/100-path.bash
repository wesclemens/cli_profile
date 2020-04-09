# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

if [[ -d $HOME/.local/bin/ ]]; then
  PATH=$HOME/.local/bin:$PATH
fi

if [[ -d $HOME/bin/ ]]; then
  PATH=$HOME/bin:$PATH
fi

