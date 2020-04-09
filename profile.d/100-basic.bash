# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

# Set readline mode to vi
set -o vi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


