GPG_TTY=$(tty)
export GPG_TTY

# needed to show passphrase dialog under a ssh session
if [ "$SSH_TTY" ]; then
	export GPG_TTY=$SSH_TTY
fi

# go paths
if [ -x "$(command -v go)" ]; then
	export GOPATH="$(go env GOPATH)"
	export PATH="$GOPATH/bin:${PATH}"
else
	export PATH="${HOME}/go/bin:${PATH}"
fi

# node npm configuration
export NPM_PACKAGES="${HOME}/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:${PATH}"

export PATH="${PATH}:${HOME}/.krew/bin"

# set default dictionary
export DICTIONARY=en_GB

. "${HOME}/.cargo/env"

export PATH="$(xcode-select -p)/usr/bin:${PATH}"

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"
export CPATH="$CPATH:/opt/homebrew/include"
export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/lib"

export PYENV_ROOT="${HOME}/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# AgDev - Agon Light C compiler
export PATH="${HOME}/software/AgDev/bin:$PATH"

# z88dk
export ZCCCFG="${HOME}/software/z88dk/lib/config"
export PATH="${PATH}:${HOME}/software/z88dk/bin"

###CPCTELERA_START
##
## These lines configure CPCtelera in your system
##

export CPCT_PATH=/Users/felix/software/cpctelera/cpctelera
export PATH=${PATH}:/Users/felix/software/cpctelera/cpctelera/tools/scripts

###CPCTELERA_END
