# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

# Docker is installed and user not a member of docker group
if command -v docker >/dev/null && groups | grep -qvE "(^| )docker( |$)"; then
  alias docker="sudo docker"
fi
