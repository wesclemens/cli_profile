# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

# If pip is installed load pip completion
if command -V pip &>/dev/null; then
  eval "`python -m pip completion --bash 2>/dev/null`"
fi

# Python Conf
if [[ -f ~/.config/python/startup.py ]]; then
  export PYTHONSTARTUP=~/.config/python/startup.py
fi

# Add user site
user_site=$(python -m site --user-site 2>/dev/null)
if [[ $? == 0 && ! -d $user_site ]]; then
  mkdir -p $user_site
fi
unset user_site
