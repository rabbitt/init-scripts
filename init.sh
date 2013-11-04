root_path=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

# preinit
source  ${root_path}/pre-init

# load environment
for mod in env alias functions 3rdparty; do
  for file in "${root_path}/${mod}.d"/*.${mod}; do
    # echo "loading: ${file}"
    source "${file}"
  done
done

# post-init
source  ${root_path}/post-init
