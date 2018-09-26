# User specific environment and startup programs
export EDITOR=vim
export ANDROID_HOME=$HOME/devel/android-sdk
export ANDROID_SDK=$ANDROID_HOME
export ANDROID_NDK_HOME=$HOME/devel/android-ndk
export ANDROID_NDK=$ANDROID_NDK_HOME
export NDK_ROOT=$ANDROID_NDK_HOME
export NDKROOT=$ANDROID_NDK_HOME
PATH=$HOME/bin:$HOME/.local/bin:$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$ANDROID_NDK:$PATH
export PATH

export MOZ_USE_OMTC=1
export MOZ_GLX_IGNORE_BLACKLIST=1

# fix for android emulator's old libstdc++
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1

if  [[ $TILIX_ID ]]; then
	source /etc/profile.d/vte.sh
fi

# node npm configuration
export NPM_PACKAGES=/home/felix/.npm-packages
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

# nim configuration
export PATH="$HOME/.nimble/bin:$PATH"

# Stop wine from creating .desktop entries
export WINEDLLOVERRIDES=winemenubuilder.exe=d

# gnome-keyring
if [ -n "$DESKTOP_SESSION" ];then
	export $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
fi

# qt themeing under i3
if [ "$XDG_CURRENT_DESKTOP" = "i3" ]; then
       export QT_QPA_PLATFORMTHEME="qt5ct"
fi

# ruby path
export PATH=$PATH:$HOME/.gem/ruby/2.5.0/bin

# go paths
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/felix/.sdkman"
[[ -s "/home/felix/.sdkman/bin/sdkman-init.sh" ]] && source "/home/felix/.sdkman/bin/sdkman-init.sh"
