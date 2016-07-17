# Only run if interactive and OS X
if ! [[ $- =~ i && $(uname) == "Darwin" ]]; then
  return
fi

# Make commands more colorful
CLICOLOR=1; export CLICOLOR

unalias ls
alias ls='ls -h'

# Enable Mac Ports
if [[ -d /opt/local/sbin ]]; then
  PATH=/opt/local/sbin:$PATH
fi

if [[ -d /opt/local/bin ]]; then
  PATH=/opt/local/bin:$PATH
fi

# Add Android SDK CLI tools to path
if [[ -d /opt/local/share/java/android-sdk-macosx ]]; then
  PATH=$PATH:/opt/local/share/java/android-sdk-macosx/tools:/opt/local/share/java/android-sdk-macosx/platform-tools
fi

# Bash autocomplete files installed with port
if [[ -f /opt/local/etc/bash_completion ]]; then
  source /opt/local/etc/bash_completion
fi

# Bash git prompt from port
if [[ -f /opt/local/share/git/git-prompt.sh ]]; then
  source /opt/local/share/git/git-prompt.sh
fi
