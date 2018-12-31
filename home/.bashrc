# ~/.bashrc: executed by bash(1) for non-login shells.

for f in $HOME/.profile.d/*.bash; do
  if [[ -f $f ]]; then
    source $f
  fi
done
unset f

