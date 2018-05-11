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

# colors
if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P01b1d1e
  \e]P1ff0044
  \e]P282b414
  \e]P3fd971f
  \e]P42686d6
  \e]P5ac0cb1
  \e]P666d9ef
  \e]P7cccccc
  \e]P8808080
  \e]P9f92672
  \e]PAa6e22e
  \e]PBe6db74
  \e]PC268bd2
  \e]PDd63ae1
  \e]PE66d9ef
  \e]PFf8f8f2
  "
  # get rid of artifacts
  clear
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/felix/.sdkman"
[[ -s "/home/felix/.sdkman/bin/sdkman-init.sh" ]] && source "/home/felix/.sdkman/bin/sdkman-init.sh"
