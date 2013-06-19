if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
HISTIGNORE=cd:ls:exit:clear
# Add some time to the history
HISTTIMEFORMAT='%F %T '

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

## Set up editors and pagers:
EDITOR=$(which vim); export EDITOR
VISUAL=$EDITOR; export VISUAL
if which less &>/dev/null; then
  PAGER=$(which less); export PAGER
else
  PAGER=$(which more); export PAGER
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen*) color_prompt=yes;;
esac
utf8_prompt=yes;

if [[ "$color_prompt" = yes ]]; then
  PROMPT_COMMAND='_RETURN_CODE=$?;'
  if [[ "$utf8_prompt" = yes ]]; then
    PS1='\[\e[0;35m\]┌─\[\e[0;36m\][\!] \[\e[0;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w$(__git_ps1 " \[\e[1;31m\](%s)")\[\e[m\]\[\e[1;32m\]\n\[\e[0;35m\]└─$([[ $_RETURN_CODE -ne 0 ]] && echo -ne "\[\e[0;31m\]($_RETURN_CODE)")\[\e[0m\] $ ';
    PS2="$(tput sc && tput cuu1 && echo -n "\[\e[0;35m\]│ \[\e[m\]"; tput rc;)\[\e[0;35m\]└─\[\e[m\] "
  else
    PS1='\[\e[0;35m\]/\[\e[0;36m\][\!] \[\e[0;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w$(__git_ps1 " \[\e[1;31m\](%s)")\[\e[m\]\[\e[1;32m\]\n\[\e[0;35m\]\\ $([[ $_RETURN_CODE -ne 0 ]] && echo -ne "\[\e[0;31m\]($_RETURN_CODE)")\[\e[0m\] $ ';
    PS2="$(tput sc && tput cuu1 && echo -n "\[\e[0;35m\]| \[\e[m\]"; tput rc;)\[\e[0;35m\]\\ \[\e[m\] "
  fi
fi
unset color_prompt utf8_prompt

# Load OS bash profile settings
if [[ -f ~/.bash_profile_$(uname) ]]; then
  source ~/.bash_profile_$(uname)
fi

# If pip is installed load pip completion
if which pip &>/dev/null; then
	eval "`pip completion --bash`"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

# Create git wrapper for git-root
function git-wrapper {
  case "$1" in
    root)
      if \git rev-parse --show-toplevel >/dev/null; then
        cd $(\git rev-parse --show-toplevel )
      else
        return $?
      fi
      ;;
    *) \git $@;;
  esac
}
alias git="git-wrapper"

# Python Conf
if [[ -f ~/.pythonrc ]]; then
  export PYTHONSTARTUP=~/.pythonrc
fi

# alias for homeshick
alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"
