
export MPD_HOST=192.168.42.1

export EMAIL="kostspielig@gmail.com"
export USERNAME="Maria Carrasco"

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c"

export LCVER=3.8
export LC="ccache clang-$LCVER"
export LXX="ccache clang++-$LCVER"

export GCVER=5
export GC="ccache gcc-$GCVER"
export GXX="ccache g++-$GCVER"
export SHLIB_GXXLD="g++-$GCVER"

# export CCFLAGS="-fdiagnostics-color=always"
# export CXXFLAGS="-fdiagnostics-color=always"

export GOPATH=~/.go-path

add-path $GOPATH/bin
add-path $HOME/usr/bin
add-path $HOME/.cabal/bin

export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules

# Guix
export CPATH=$HOME/.guix-profile/include
export LIBRARY_PATH=$HOME/.guix-profile/lib
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale
export GUILE_LOAD_PATH=$HOME/.guix-profile/share/guile/site/2.0
export GUILE_LOAD_COMPILED_PATH=$HOME/.guix-profile/share/guile/site/2.0
add-path $HOME/.guix-profile/bin
add-path $HOME/.guix-profile/sbin

# Maria's environment
add-path $HOME/.rvm/bin # Add RVM to PATH for scripting
add-path $HOME/.rvm/scripts/rvm
add-path /home/maria/google-cloud-sdk/platform/google_appengine/
source $HOME/google-cloud-sdk/path.bash.inc
source $HOME/google-cloud-sdk/completion.bash.inc
add-path $HOME/.local/bin
source "$HOME/.rvm/scripts/rvm"
