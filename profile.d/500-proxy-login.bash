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

  # Get host
  local host=
  local curr_host=$( echo $curr_settings | sed -n "s/.*@\(.*\)$/\1/p")
  if [[ -z "$curr_host" ]]; then
    read -p "Host: " host
  else
    read -p "Host [${curr_host}]: " host
  fi
  if [[ -z "$host" ]]; then
    host=$curr_host
  fi

  if [[ -z "$host" ]]; then
    1>&2 echo "Host cannot be blank"
    return 1
  fi

  # Get user
  local user=
  local curr_user=$(echo $cur_settings | sed -n "s/.*\/\/\([^@:]*\).*$/\1/p")
  if [[ -z "$curr_user" ]]; then
    read -p "Username: " user
  else
    read -p "Username [${curr_user}]: " user
  fi
  if [[ -z "$user" ]]; then
    user=$curr_user
  fi

  # Get password
  local password=
  if [[ -n "$user" ]]; then
    read -sp"Please enter your proxy password: " password
    printf "\n"

    if [[ -n "$password" ]]; then
      password=":$(urlencode ${password})"
    fi
  fi

  case $protocol in
    ftp )
      export ftp_proxy=http://${user}${password}@${host}
      ;;
    http )
      export http_proxy=http://${user}${password}@${host}
      ;;
    https )
      export https_proxy=http://${user}${password}@${host}
      ;;
    ALL )
      export ftp_proxy=http://${user}${password}@${host}
      export http_proxy=http://${user}${password}@${host}
      export https_proxy=http://${user}${password}@${host}
      ;;
  esac
}
