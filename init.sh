function have_path() {
  [ $# -ne 1 ] && return
  echo "${PATH}" | grep -qP "(?:^|:)($1)(?::|$)"
}

function push_path() {
  have_path "$1" && return
  export PATH="${PATH}:$1"
}
alias append_path=push_path

function shift_path() {
  have_path "$1" && return
  export PATH="$1:${PATH}"
}
alias prepend_path=shift_path

function readlink() {
  local _readlink="$(which readlink)"

  if ${_readlink} --version . 2>&1 | grep -q GNU; then
    ${_readlink} -f "$@"
  else
    perl -e "use Cwd qw(abs_path); print abs_path(glob('$@'));"
  fi
}

root_path="${HOME}/.init-scripts"

# load base environment
source  ${root_path}/pre-init
for _mod in env alias functions 3rdparty; do
  for _file in "${root_path}/${_mod}.d"/*.${_mod}; do
    source "${_file}"
  done 2>/dev/null
done
source  ${root_path}/post-init


# load user environments from ~/.env.d, ~/.alias.d,
# ~/.functions.d, ~/.3rdparty.d
[ -f "${HOME}/.bash-pre-init" ] && source  "${HOME}/.bash-pre-init"
for _mod in env alias functions 3rdparty; do
  [ ! -d "${HOME}/.${_mod}.d" ] && continue

  for _file in "${root_path}/${_mod}.d"/*.${_mod}; do
    source "${_file}"
  done 2>/dev/null
done
[ -f "${HOME}/.bash-post-init" ] && source  "${HOME}/.bash-post-init"

unset root_paths _mod _file
