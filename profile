# User specific environment and startup programs

# start X session
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && export XDG_CURRENT_DESKTOP=i3 && \
#	export XDG_SESSION_DESKTOP=i3 && startx > /dev/null 2>&1 && reset

# gcc colors
export GCC_COLORS=error="01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
export EDITOR=nvim
export ANDROID_HOME="$HOME/devel/android-sdk"
export ANDROID_SDK="$ANDROID_HOME"
export ANDROID_NDK_HOME="$HOME/devel/android-ndk"
export ANDROID_NDK="$ANDROID_NDK_HOME"
export NDK_ROOT="$ANDROID_NDK_HOME"
export NDKROOT="$ANDROID_NDK_HOME"
PATH="$HOME/bin:$HOME/.local/bin:$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$ANDROID_NDK:$PATH"
export PATH

export MOZ_USE_OMTC=1
export MOZ_GLX_IGNORE_BLACKLIST=1
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1

# fix for android emulator's old libstdc++
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1

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

# qt themeing under i3 and gnome
if [ "$XDG_CURRENT_DESKTOP" = "i3" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] ; then
	export QT_QPA_PLATFORMTHEME="qt5ct"
fi

# gnome-keyring under i3 and plasma
if [ "$XDG_CURRENT_DESKTOP" = "i3" ] || [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
	eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
	export SSH_AUTH_SOCK
fi

# ruby path
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

# go paths
GO_BINARY=$(which go)
if [ -f "$GO_BINARY" ]; then
	export GOPATH="$(go env GOPATH)"
	export PATH="$GOPATH/bin:$PATH"
fi

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# remove duplicates from PATH
export PATH=$(printf "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
