# ~/.bashrc: executed by bash(1) for non-login shells.

for f in $HOME/.bash_env.d/*.bash; do
  if [[ -f $f ]]; then
    source $f
  fi
done

