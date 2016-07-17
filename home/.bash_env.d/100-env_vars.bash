# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

## Set up editors and pagers:
EDITOR=$(command -v vim); export EDITOR
VISUAL=$EDITOR; export VISUAL
if command -v less >/dev/null; then
  PAGER=$(command -v less); export PAGER
else
  PAGER=$(command -v more); export PAGER
fi

