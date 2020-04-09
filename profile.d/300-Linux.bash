# Only run if interactive and Linux
if ! [[ $- =~ i && $(uname) == "Linux" ]]; then
  return
fi

# Set up dir colors
if [[ -x "$(command -v dircolors)" ]]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias ls='ls -h --color=auto'
alias dir='dir -h --color=auto'
alias vdir='vdir -h --color=auto'

# Bash completion
if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

# Alias xdg-open to open match MacOS
if env | grep "^XDG_" &>/dev/null; then
  alias open="&>/dev/null xdg-open"
fi
