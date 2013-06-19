# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [[ -d $HOME/bin/ ]]; then
  PATH=$HOME/bin:$PATH
fi


if [[ -d $HOME/.rvm/bin ]]; then
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

#Global npm apps
if [[ -d /usr/local/share/npm/bin ]]; then
  PATH=$PATH:/usr/local/share/npm/bin
fi

# Python path
if [[ -d /usr/local/lib/python2.7/site-packages ]]; then
  # Don't know if this is proper. Should I do this?
  export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
fi

# Android Dev
if [[ -d /Applications/Android\ Studio.app/sdk/platform-tools ]]; then
  PATH=$PATH:/Applications/Android\ Studio.app/sdk/platform-tools
fi

# Add rbenv to path
if which rbenv &>/dev/null; then
  eval "$(rbenv init -)"
fi

# Load OS bashrc settings
if [[ -f ~/.bashrc_$(uname) ]]; then
  source ~/.bashrc_$(uname)
fi
