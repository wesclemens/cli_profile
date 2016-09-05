# System specific aliases should be found in 210-<kernal>.bash
# Aliases must be loaded after environment variables

# Only run if interactive
if ! [[ $- =~ i && $(uname) == "Linux" ]]; then
  return
fi

alias which='command -v'

alias ls='ls -h --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias less='less -R'
alias du='du -h'
alias screen='screen -U'
alias tmux='tmux -2'

alias p="ps -fu $USER"
