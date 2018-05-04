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
  \e]P01d1f21
  \e]P1cc6666
  \e]P2b5bd68
  \e]P3f0c674
  \e]P481a2be
  \e]P5b294bb
  \e]P68abeb7
  \e]P7c5c8c6
  \e]P8969896
  \e]P9cc6666
  \e]PAb5bd68
  \e]PBf0c674
  \e]PC81a2be
  \e]PDb294bb
  \e]PE8abeb7
  \e]PFffffff
  "
  # get rid of artifacts
  clear
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/felix/.sdkman"
[[ -s "/home/felix/.sdkman/bin/sdkman-init.sh" ]] && source "/home/felix/.sdkman/bin/sdkman-init.sh"
