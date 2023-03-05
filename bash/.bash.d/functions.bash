
del-path()
{
    PATH=${PATH//":$1"/} # delete in the middle or at the end
    PATH=${PATH//"$1:"/} # delete at the beginning
}

add-path()
{
    del-path $1
    PATH="$1:$PATH" # prepend to beginning
}

dk()
{
  case $1 in
    ip )
      docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
    ;;
    container )
      docker ps -a
    ;;
  esac
}

mkcd()
{
    test -d "$1" || mkdir "$1" && cd "$1"
}

# Public: Change to a development directory and load .env file.
#
# Takes a single argument that can either be full path of the project or name of
# a project under ~/dev/* directory
#
# $1 - [Path to] project.
#
# Examples
#
#   cdenv ~/dev/maria
#
cdenv()
{
    if test -d ~/dev/"$1"; then cd ~/dev/"$1"; else echo cd "$1"; fi && source .env
}
