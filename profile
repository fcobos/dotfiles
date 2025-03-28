# User specific environment and startup programs

PAGER=less
export EDITOR=vi
export BROWSER=xdg-open
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH

# node npm configuration
export NPM_PACKAGES="/home/felix/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

# nim configuration
export PATH="$HOME/.nimble/bin:$PATH"

# Stop wine from creating .desktop entries
export WINEDLLOVERRIDES=winemenubuilder.exe=d

# needed to show passphrase dialog under a ssh session
if [ "$SSH_TTY" ]; then
	export GPG_TTY=$SSH_TTY
fi

# ruby path
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# go paths
if [ -x "$(command -v go)" ]; then
	export GOPATH="$(go env GOPATH)"
	export PATH="$GOPATH/bin:$PATH"
else
	export PATH="$HOME/go/bin:$PATH"
fi

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# android tools
export ANDROID_HOME=$HOME/devel/android/sdk
export ANDROID_SDK=$ANDROID_HOME
export ANDROID_NDK_HOME=$HOME/devel/android/sdk/ndk-bundle
export ANDROID_NDK=$ANDROID_NDK_HOME
export NDK_ROOT=$ANDROID_NDK_HOME
export NDKROOT=$ANDROID_NDK_HOME
# fix for android emulator's old libstdc++
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$NDKROOT:$PATH"

# krew path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# hombrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# remove duplicates from PATH
export PATH=$(printf "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
