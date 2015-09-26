VIRTUAL_ENV_AUTO="False"
function cd-wrapper {
  # Change Directory
  builtin cd $@

  if [[ -n "$VIRTUAL_ENV" && "$VIRTUAL_ENV_AUTO" == "True" ]]; then
    if [[ $(pwd) != $(dirname $VIRTUAL_ENV)* ]]; then
      deactivate
    fi
  fi

  if [[ -z "$VIRTUAL_ENV" ]]; then
    # Check if in a git directory
    if git rev-parse &>/dev/null; then
      local env_dir=$(git rev-parse --show-toplevel)/.venv
      if [[ -f $env_dir/bin/activate ]]; then
        VIRTUAL_ENV_AUTO="True"
        source $env_dir/bin/activate
      fi
    fi
  fi
}

alias cd="cd-wrapper"

cd-wrapper . 
