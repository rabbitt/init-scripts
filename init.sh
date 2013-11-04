case "$(uname -s)" in
  Darwin)
    export readlink="$(ruby -rpathname -e "print Pathname.new('$0').realpath.dirname")/bin/ruby-readlink";;
  Linux)
    export readlink="$(which readlink)";;
  *)
    echo "Unsupported OS: $(uname -s)"
    exit 1;;
esac

root_path=$(dirname $($readlink -f ${BASH_SOURCE[0]}))

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