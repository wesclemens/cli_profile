# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

# If pip is installed load pip completion
if command -v pip >/dev/null; then
  eval "`pip completion --bash`"
fi

# Python Conf
if [[ -f ~/.pythonrc ]]; then
  export PYTHONSTARTUP=~/.pythonrc
fi

# Add user site
user_site=$(python -m site --user-site 2>/dev/null)
if [[ $? == 0 && ! -d $user_site ]]; then
  mkdir -p $user_site
fi
unset user_site
