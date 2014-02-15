if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set readline mode to vi
set -o vi

# Set audocd
[ ${BASH_VERSINFO[0]} -ge 4 ] && shopt -s autocd

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
function __fancy_prompt {
  local _rc=$?; # Trap return code
  local utf8_prompt=yes # Need to find a way to detect this
  local color_prompt=no

  case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    screen*) color_prompt=yes;;
  esac

  if [[ "$color_prompt" = yes ]]; then
    local c_clear='\[\e[0m\]'
    local c_purple='\[\e[0;35m\]'
    local c_lightblue='\[\e[0;36m\]'
    local c_green='\[\e[0;32m\]'
    local c_red='\[\e[0;31m\]'
    local c_lightred='\[\e[1;31m\]'
    local c_lightgreen='\[\e[1;34m\]'
    local c_orange='\[\e[38;5;208m\]'
    local c_darkpurple='\[\e[38;5;055m\]'
  fi

  if [[ "$utf8_prompt" = yes ]]; then
    local bracket_top=${c_purple}┌─
    local bracket_middle="${c_purple}│ "
    local bracket_bottom=${c_purple}└─
  else
    local bracket_top=${c_purple}/
    local bracket_middle="${c_purple}| "
    local bracket_bottom=${c_purple}\\\\; # Need to double escape
  fi

  if [[ ${_rc} -ne 0 ]]; then
    local return_code=${c_red}\(${_rc}\)
  fi

  local hist=${c_lightblue}[\\!]
  local user=${c_green}\\u
  local host=\\h
  local cwd=${c_lightgreen}\\w
  if [[ "$(type -t  __git_ps1)" == "function" ]]; then
    local vc_branch=" $(__git_ps1 "${c_lightred}(%s)")"
  else
    local vs_branch=""
  fi
  local cmd_mark="${c_clear} \\$ "

  if [[ -n "$VIRTUAL_ENV" ]]; then
    local virt_env=" ${c_orange}[$(basename $VIRTUAL_ENV)]"
  fi

  if [[ $SHLVL -gt 1 ]]; then
    local sh_lv_ind=" ${c_darkpurple}*"
  fi

  PS1="${bracket_top}${hist} ${user}@${host}${c_clear}:${cwd}${sh_lv_ind}${virt_env}${vc_branch}${c_clear}\n${bracket_bottom}${return_code}${cmd_mark}";
  PS2="$(tput sc && tput cuu1 && echo -n "${bracket_middle}"; tput rc;)${bracket_bottom}${c_clear} "
}
PROMPT_COMMAND="__fancy_prompt; $PROMPT_COMMAND"

# Load OS bash profile settings
if [[ -f ~/.bash_profile_$(uname) ]]; then
  source ~/.bash_profile_$(uname)
fi

# Load local bash profile
if [[ -f ~/.bash_profile_local ]]; then
  source ~/.bash_profile_local
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
        cd "$(\git rev-parse --show-toplevel )"
      else
        return $?
      fi
      ;;
    *) \git "$@";;
  esac
}
alias git="git-wrapper"

# Python Conf
if [[ -f ~/.pythonrc ]]; then
  export PYTHONSTARTUP=~/.pythonrc
fi

# alias for homeshick
if [[ -f $HOME/.homesick/repos/homeshick/home/.homeshick ]]; then
  source $HOME/.homesick/repos/homeshick/homeshick.sh
else
  echo "Homeshick is not installed something is wrong?!?!"
fi
