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

# Stop wine from creating .desktop entries
export WINEDLLOVERRIDES=winemenubuilder.exe=d

# gnome-keyring
if [ -n "$DESKTOP_SESSION" ];then
	export $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
fi

# linux console colors
if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P0000000
  \e]P1ff5555
  \e]P250fa7b
  \e]P3f1fa8c
  \e]P4bd93f9
  \e]P5ff79c6
  \e]P68be9fd
  \e]P7bfbfbf
  \e]P84d4d4d
  \e]P9ff6e67
  \e]PA5af78e
  \e]PBf4f99d
  \e]PCcaa9fa
  \e]PDff92d0
  \e]PE9aedfe
  \e]PFe6e6e6
  "
  # get rid of artifacts
  clear
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/felix/.sdkman"
[[ -s "/home/felix/.sdkman/bin/sdkman-init.sh" ]] && source "/home/felix/.sdkman/bin/sdkman-init.sh"
