if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set readline mode to vi
set -o vi

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

