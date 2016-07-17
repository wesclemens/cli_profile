# Only run if interactive
if ! [[ $- =~ i && $(uname) == "Linux" ]]; then
  return
fi

alias which='command -v'

if [[ -x /usr/bin/dircolors ]]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls -h --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias less='less -R'
alias du='du -h'
alias screen='screen -U'

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

