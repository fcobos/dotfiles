GPG_TTY=$(tty)
export GPG_TTY

# needed to show passphrase dialog under a ssh session
if [ "$SSH_TTY" ]; then
	export GPG_TTY=$SSH_TTY
fi

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# go paths
if [ -x "$(command -v go)" ]; then
	export GOPATH="$(go env GOPATH)"
	export PATH="$GOPATH/bin:$PATH"
else
	export PATH="$HOME/go/bin:$PATH"
fi

# node npm configuration
export NPM_PACKAGES="/home/felix/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"

export PATH="${PATH}:${HOME}/.krew/bin"

. "$HOME/.cargo/env"
#export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
#export PATH="/Library/Developer/CommandLineTools/usr/bin:$PATH"
export PATH="$(xcode-select -p)/usr/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
