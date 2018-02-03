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
  \e]P0181818
  \e]P1ab4642
  \e]P2a1b56c
  \e]P3f7ca88
  \e]P47cafc2
  \e]P5ba8baf
  \e]P686c1b9
  \e]P7d8d8d8
  \e]P8585858
  \e]P9dc9656
  \e]PAc5d59b
  \e]PBf0c674
  \e]PC81a2be
  \e]PDb294bb
  \e]PE8abeb7
  \e]PFc5c8c6
  "
  # get rid of artifacts
  clear
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/felix/.sdkman"
[[ -s "/home/felix/.sdkman/bin/sdkman-init.sh" ]] && source "/home/felix/.sdkman/bin/sdkman-init.sh"
