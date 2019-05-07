
export MPD_HOST=192.168.42.1

export EMAIL="kostspielig@gmail.com"
export USERNAME="Maria Carrasco"

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
export VISUAL="emacsclient -c"

#
# C++
#
export LCVER=3.8
export LC="clang-$LCVER"
export LXX="clang++-$LCVER"

export GCVER=6
export GC="gcc-$GCVER"
export GXX="g++-$GCVER"
export SHLIB_GXXLD="g++-$GCVER"

#
# SoundCloud
#
export SC_TOOLS_HOME=$HOME/dev/soundcloud/sc-tools-target/linux_amd64
export SYSTEM=$HOME/.gem/ruby/2.5.0/bin/
export GEM_PATH=$GEM_PATH:$HOME/.gem/ruby/2.5.0/

add-path $SC_TOOLS_HOME
add-path $SYSTEM


use-clang() {
    export CC=$LC
    export CXX=$LXX
}

use-gcc() {
    export CC=$GC
    export CXX=$GXX
}

disable-ccache() {
    export CC=${CC#ccache}
    export CXX=${CXX#ccache}
}

use-ccache() {
    disable-ccache
    export CC="ccache $CC"
    export CXX="ccache $CXX"
}

if [ "$(uname)" == "Darwin" ]; then
    use-clang
else
    use-gcc
fi

# export CCFLAGS="-fdiagnostics-color=always"
# export CXXFLAGS="-fdiagnostics-color=always"

export CTEST_OUTPUT_ON_FAILURE=1


#
# emscripten
#
add-path $HOME/soft/binaryen/build/bin
add-path $HOME/dev/emsdk
[ -f $HOME/dev/emsdk/emsdk_set_env.sh ] && \
    source $HOME/dev/emsdk/emsdk_set_env.sh

#
# Go
#
export GOPATH=~/go
add-path $GOPATH/bin
add-path /usr/local/go/bin

#
# Local installs
#
add-path /usr/local/bin
add-path ~/usr/bin
add-path ~/.local/bin

#
# Haskell
#
add-path ~/.cabal/bin

#
# Kotlin
#

add-path /usr/lib/kotlin-native-linux-1.3.10/bin

#
# Node.js
#
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules

add-path $HOME/node_modules/.bin

#
# Google cloud stuff
#

add-path ~/google-cloud-sdk/platform/google_appengine/
add-path ~/go_appengine/
[ -f ~/google-cloud-sdk/completion.bash.inc ] && \
    source ~/google-cloud-sdk/completion.bash.inc
[ -f ~/google-cloud-sdk/path.bash.inc ] && \
    source ~/google-cloud-sdk/path.bash.inc

#
# Travis
#
[ -f ~/.travis/travis.sh ] && \
    source ~/.travis/travis.sh

#
# Nix
#
if [ -e /home/maria/.nix-profile/etc/profile.d/nix.sh ];
then
    source /home/maria/.nix-profile/etc/profile.d/nix.sh;
fi
