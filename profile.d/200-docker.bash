# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

if command -v >/dev/null; then
  alias docker="sudo docker"
fi
