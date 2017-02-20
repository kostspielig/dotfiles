
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

export GCVER=5
export GC="gcc-$GCVER"
export GXX="g++-$GCVER"
export SHLIB_GXXLD="g++-$GCVER"

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
# Node.js
#
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules

add-path $HOME/npm-global/bin

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
# Guix
#
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

add-path $HOME/.local/bin
source "$HOME/.rvm/scripts/rvm"

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
add-path /usr/share/apache-maven-3.0.5/bin

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

#eval $(ssh-agent -s)
#ssh-add

#
# Clojure
#
# export LEIN_FAST_TRAMPOLINE=true
