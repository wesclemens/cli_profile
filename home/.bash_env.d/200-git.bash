# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

# Create git wrapper for git
function git-wrapper {
  case "$1" in
    root)
      if \git rev-parse --show-toplevel >/dev/null; then
        cd "$(\git rev-parse --show-toplevel )"
      else
        return $?
      fi
      ;;
    ctags)
      git_dir="$(git rev-parse --git-dir 2>/dev/null)"
      $git_dir/hooks/ctags
      ;;
    *) \git "$@";;
  esac
}
alias git="git-wrapper"
