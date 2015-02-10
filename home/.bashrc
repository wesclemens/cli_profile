# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [[ -d $HOME/bin/ ]]; then
  PATH=$HOME/bin:$PATH
fi

for f in $HOME/.bash_env.d/*.bash; do
  if [[ -f $f ]]; then
    source $f
  fi
done

