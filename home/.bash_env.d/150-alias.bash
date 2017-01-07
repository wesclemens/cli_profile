# System specific aliases should be found in 210-<kernal>.bash
# Aliases must be loaded after environment variables

# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

alias which='command -v'

alias ls='ls -h'
alias dir='dir -h'
alias vdir='vdir -h'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias less='less -R'
alias du='du -h'
if command -v screen &>/dev/null; then
  alias screen='screen -U'
fi
alias tmux='tmux -2'

alias p="ps -fu $USER"
