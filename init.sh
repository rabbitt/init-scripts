root_path="${HOME}/.init-scripts"

# preinit
source  ${root_path}/pre-init

# load environment
for _mod in env alias functions 3rdparty; do
  for _file in "${root_path}/${_mod}.d"/*.${_mod}; do
    # echo "loading: ${_file}"
    source "${_file}"
  done
done

# post-init
source  ${root_path}/post-init

unset root_paths _mod _file