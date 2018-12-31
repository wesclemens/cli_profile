# Only run if interactive
if ! [[ $- =~ i ]]; then
  return
fi

# Source git completion
if ! command -V __git_ps1 &> /dev/null; then
  [ -r /usr/share/git/completion/git-prompt.sh ] && source /usr/share/git/completion/git-prompt.sh
fi

# set a fancy prompt (non-color, unless we know we "want" color)
function __fancy_prompt {
  local _rc=$?; # Trap return code
  local utf8_prompt=no # Need to find a way to detect this
  local color_prompt=no

  if [[ "$(locale charmap)" == "UTF-8" ]]; then
    utf8_prompt=yes
  fi

  if [[ "$(tput colors)" > 2 ]]; then
    color_prompt=yes
  else
    case "$TERM" in
      xterm-color) color_prompt=yes;;
      xterm-256color) color_prompt=yes;;
      screen*) color_prompt=yes;;
    esac
  fi

  if [[ "$color_prompt" = yes ]]; then
    local c_clear='\[\e[0m\]'
    local c_purple='\[\e[0;35m\]'
    local c_lightblue='\[\e[0;36m\]'
    local c_green='\[\e[0;32m\]'
    local c_red='\[\e[0;31m\]'
    local c_lightred='\[\e[1;31m\]'
    local c_lightgreen='\[\e[1;34m\]'
    local c_orange='\[\e[38;5;208m\]'
    local c_darkpurple='\[\e[38;5;055m\]'
  fi

  if [[ "$utf8_prompt" = yes ]]; then
    local bracket_top=${c_purple}┌─
    local bracket_middle="${c_purple}│ "
    local bracket_bottom=${c_purple}└─
  else
    local bracket_top=${c_purple}/
    local bracket_middle="${c_purple}| "
    local bracket_bottom=${c_purple}\\\\; # Need to double escape
  fi

  if [[ ${_rc} -ne 0 ]]; then
    local return_code=${c_red}\(${_rc}\)
  fi

  local hist=${c_lightblue}[\\!]
  local user=${c_green}\\u
  local host=\\h
  local cwd=${c_lightgreen}\\w
  if [[ "$(type -t  __git_ps1)" == "function" && -n "$(__git_ps1)" ]]; then
    local vc_branch=" $(__git_ps1 "${c_lightred}(%s)")"
  elif [[ -n "$(hg branch 2>/dev/null)" ]]; then
    local vc_branch=" ${c_lightred}($(hg branch 2>/dev/null))"
  else
    local vs_branch=""
  fi
  local cmd_mark="${c_clear} \\$ "

  if [[ -n "$VIRTUAL_ENV" ]]; then
    local virt_env=" ${c_orange}[$(basename $VIRTUAL_ENV)]"
  fi

  if [[ $SHLVL -gt 1 ]]; then
    local sh_lv_ind=" ${c_darkpurple}*"
  fi

  PS1="${bracket_top}${hist} ${user}@${host}${c_clear}:${cwd}${sh_lv_ind}${virt_env}${vc_branch}${c_clear}\n${bracket_bottom}${return_code}${cmd_mark}";
  PS2="$(tput sc && tput cuu1 && echo -n "${bracket_middle}"; tput rc;)${bracket_bottom}${c_clear} "
}
PROMPT_COMMAND="__fancy_prompt; $PROMPT_COMMAND"

