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
EDITOR=$(command -v vim); export EDITOR
VISUAL=$EDITOR; export VISUAL
if command -v less >/dev/null; then
  PAGER=$(command -v less); export PAGER
else
  PAGER=$(command -v more); export PAGER
fi

