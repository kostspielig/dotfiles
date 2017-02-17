
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

zal()
{
  base_path=~/Devel/shop/;
  components=webapp/src/main/frontend-components/;
  [[ $PWD/ != $base_path ]]; cd $base_path;

  case $1 in
    tmux )
      tmux new -s shop "${@:2}"
    ;;
    build )
      mvn clean install -Pcd -pl webapp/src/main/frontend-components
      scripts/build.sh -f "${@:2}"
    ;;
    run )
      scripts/run.sh -d "${@:2}"
    ;;
    gulp )
      cd $components && gulp dev --nojsp "${@:2}"
    ;;
    tdd )
      cd $components && gulp tdd "${@:2}"
    ;;
    dev )
      cd webapp/ && zile "${@:2}"
    ;;
    mvn )
      case $2 in
        clean )
           mvn clean install -U "${@:3}"
        ;;
        run )
          mvn tomcat7:run-war-only "${@:3}"
        ;;
      esac
    ;;
  esac
}
