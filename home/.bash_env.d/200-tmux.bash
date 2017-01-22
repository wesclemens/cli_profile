# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

# Only run if in TMUX
if [[ -z "$TMUX" ]]; then
  return
fi

settitle() {
  printf "\033k%s\033\\" "$@"
}

PROMPT_COMMAND="$PROMPT_COMMAND settitle bash;"
