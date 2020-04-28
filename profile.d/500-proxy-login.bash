function urlencode() {
  if python -V 2>&1 | grep "^Python 2" &> /dev/null; then
    python -c "from urllib import quote as f; print f('''${1}''')"
  else
    python -c "from urllib.parse import quote as f; print(f('''${1}'''))"
  fi
  return $?
}

function proxy-login() {
  local protocol=${1-ALL}
  local host=${2-}
  local user=${3-}

  local curr_settings=
  case $protocol in
    http|ALL )
      curr_settings=$http_proxy ;;
    https )
      curr_settings=$https_proxy ;;
    ftp )
      curr_settings=$ftp_proxy ;;
    * )
      1>&2 echo "Unknown protocol giving up"
      return 1
      ;;
  esac

  local REGEX="^(https?)://(([^:]*)(:([^@]*))?@)?([^:]*)(:(.*))?$"
  # Capture Groups:  1 - Protocol   3 - User  5 - Password  6 - Host  8 - Port
  # Example:  var=$(echo $curr_settings | sed -n -E "s|${REGEX}|\1|p")

  # Get host
  if [[ -z "$host" ]]; then
    local curr_port=$(echo $curr_settings | sed -n -E "s|${REGEX}|\8|p")
    local curr_host=$(echo $curr_settings | sed -n -E "s|${REGEX}|\6|p")
    if [[ -n "$curr_port" ]] && [[ -n "$curr_host" ]]; then
      curr_host=$curr_host:$curr_port
    fi

    if [[ -z "$curr_host" ]]; then
      printf "Host: "
    else
      printf "Host [${curr_host}]: "
    fi
    read host
    if [[ -z "$host" ]]; then
      host=$curr_host
    fi

    if [[ -z "$host" ]]; then
      1>&2 echo "Host cannot be blank"
      return 1
    fi
  fi

  # Get user
  if [[ -z "$user" ]]; then
    local curr_user=$(echo $curr_settings | sed -n -E "s|${REGEX}|\3|p")
    [[ -z "$curr_user" ]] && curr_user=$(whoami)
    if [[ -z "$curr_user" ]]; then
      printf "Username: "
    else
      printf "Username [${curr_user}] (Escape to clear): "
    fi
    read user
    if [[ -z "$user" ]]; then
      user=$curr_user
    fi
    # Check for Esc key
    if [[ "$user" == $'\e' ]]; then
      user=
    fi
  fi

  # Get password
  local password=
  if [[ -n "$user" ]]; then
    printf "Please enter your proxy password: "
    read -s password
    printf "\n"

    if [[ -n "$password" ]]; then
      password="$(urlencode ${password})"
    fi
  fi

  local proxy=${host}
  if [[ -n "$user" ]] && [[ -n "$password" ]]; then
    proxy="$user:$password@${host}"
  elif [[ -n "$user" ]]; then
    proxy="$user@${host}"
  fi

  case $protocol in
    ftp )
      export ftp_proxy=http://$proxy
      ;;
    http )
      export http_proxy=http://$proxy
      ;;
    https )
      export https_proxy=http://$proxy
      ;;
    ALL )
      export ftp_proxy=http://$proxy
      export http_proxy=http://$proxy
      export https_proxy=http://$proxy
      ;;
  esac
}
