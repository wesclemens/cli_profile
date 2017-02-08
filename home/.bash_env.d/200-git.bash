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

# Setup Git prompt
for dir in "/usr/local/git/contrib/completion/" \
           "/Applications/Xcode.app/Contents/Developer/usr/share/git-core/"
do
  if [[ -f "${dir}/git-completion.bash" ]]; then
    source "${dir}/git-completion.bash"
  fi
done


# Setup Git completion
for dir in "/usr/local/git/contrib/completion/" \
           "/Applications/Xcode.app/Contents/Developer/usr/share/git-core/"
do
  if [[ -f "${dir}/git-prompt.sh" ]]; then
    source "${dir}/git-prompt.sh"
  fi
done

# clean up local vars
unset dir
