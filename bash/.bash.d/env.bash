
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

# Setup ssh-agent

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /run/current-system/sw/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /run/current-system/sw/bin/ssh-add;
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
# Local installs
#
add-path /usr/local/bin
add-path ~/usr/bin


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
