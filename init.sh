function readlink() {
  local _readlink="$(which readlink)"

  if ${_readlink} --version . 2>&1 | grep -q GNU; then
    ${_readlink} -f "$@"
  else
    perl -e "use Cwd qw(abs_path); print abs_path(glob('$@'));"
  fi
}

root_path="${HOME}/.init-scripts"

# preinit
source  ${root_path}/pre-init

# load environment
for _mod in env alias functions 3rdparty; do
  for _file in "${root_path}/${_mod}.d"/*.${_mod}; do
    # echo "loading: ${_file}"
    source "${_file}"
  done 2>/dev/null
done

# post-init
source  ${root_path}/post-init

unset root_paths _mod _file