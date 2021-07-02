PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH

export FPATH="/opt/homebrew/share/zsh/site-functions:$FPATH"

if [ -f ~/.profile ]; then
	. ~/.profile
fi
