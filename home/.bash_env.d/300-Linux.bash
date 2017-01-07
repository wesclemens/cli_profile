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

# Set up Git prompt
if [[ -f /usr/local/git/contrib/completion/git-prompt.sh ]]; then
  source /usr/local/git/contrib/completion/git-prompt.sh
fi

# Bash completion
if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

# Set up Git completion
if [[ -f /usr/local/git/contrib/completion/git-completion.bash ]]; then
  source /usr/local/git/contrib/completion/git-completion.bash
fi

