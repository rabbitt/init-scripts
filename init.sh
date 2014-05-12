root_path="${HOME}/.init-scripts"
source "${root_path}/lib/path.functions"

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
