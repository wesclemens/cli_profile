# Only run if interactive
[[ $- =~ i ]] || return

if command -v bat >/dev/null; then
  alias cat="bat"
  export BAT_THEME=GitHub
fi
