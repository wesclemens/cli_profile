# ~/.bashrc: executed by bash(1) for non-login shells.
# Local settings should be stored in ~/.localprofile

HOMESHICK_CLI_PROFILE=$(realpath $(dirname $(readlink -f $HOME/.bashrc))/../)

for f in $HOMESHICK_CLI_PROFILE/profile.d/*.bash; do
  if [[ -f $f ]]; then
    source $f
  fi
done

if [[ -f $HOME/.localprofile ]]; then 
  source $HOME/.localprofile
fi

unset f HOMESHICK_CLI_PROFILE

