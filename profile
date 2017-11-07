# User specific environment and startup programs
PATH=$HOME/bin:$HOME/.local/bin:$HOME/devel/android-sdk/emulator:$HOME/devel/android-sdk/tools:$HOME/devel/android-sdk/platform-tools:$HOME/devel/android-ndk:$HOME/.gem/ruby/2.4.0/bin:$PATH
export PATH
export EDITOR=vim
export ANDROID_HOME=$HOME/devel/android-sdk
export ANDROID_SDK=$ANDROID_HOME
export ANDROID_NDK_HOME=$HOME/devel/android-ndk
export ANDROID_NDK=$ANDROID_NDK_HOME
export NDK_ROOT=$ANDROID_NDK_HOME
export NDKROOT=$ANDROID_NDK_HOME
#export KOTLIN_HOME=/usr/share/kotlin
#export KT_HOME=$KOTLIN_HOME

export MOZ_USE_OMTC=1
export MOZ_GLX_IGNORE_BLACKLIST=1

# fix couldn't register with accesibility bus warning
#export NO_AT_BRIDGE=1

# fix for android emulator's old libstdc++
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1

if  [[ $TILIX_ID ]]; then
	source /etc/profile.d/vte.sh
fi

# set the umask
#umask 077

# node npm configuration
export NPM_PACKAGES=/home/felix/.npm-packages
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

# To enable the keyring for applications run through the terminal, such as SSH
if [ -n "$DESKTOP_SESSION" ];then
	eval $(gnome-keyring-daemon --start)
	export SSH_AUTH_SOCK
fi

# Stop wine from creating .desktop entries
export WINEDLLOVERRIDES=winemenubuilder.exe=d

# fix electron plasma globalmenu
export ELECTRON_FORCE_WINDOW_MENU_BAR=1
