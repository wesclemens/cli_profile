# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

# If pip is installed load pip completion
if which pip &>/dev/null; then
  eval "`pip completion --bash`"
fi

# Python Conf
if [[ -f ~/.pythonrc ]]; then
  export PYTHONSTARTUP=~/.pythonrc
fi

