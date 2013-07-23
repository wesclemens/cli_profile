# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [[ -d $HOME/bin/ ]]; then
  PATH=$HOME/bin:$PATH
fi

# Load OS bashrc settings
if [[ -f ~/.bashrc_$(uname) ]]; then
  source ~/.bashrc_$(uname)
fi

# Load local bashrc if exists
if [[ -f ~/.bashrc_local ]]; then
  source ~/.bashrc_local
fi
