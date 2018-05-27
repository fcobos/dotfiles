# see http://www.joshuad.net/zshrc-config/
# https://github.com/sindresorhus/pure
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HIST_STAMPS="yyyy-mm-dd"
SAVEHIST=10000
HISTSIZE=50000
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt append_history         # Allow multiple terminal sessions to all append to one zsh command history
setopt hist_reduce_blanks     # Remove extra blanks from each command line being added to history

setopt ZLE # Enable the ZLE line editor, which is default behavior, but to be sure
unsetopt NO_HUP # Kill all child processes when we exit, do not leave them running
setopt INTERACTIVE_COMMENTS # Allows comments in interactive shell.

# Autoload auto completion
autoload -U compinit
compinit -i
zstyle ':completion:*' menu select # Have the menu highlight as we cycle through options
## case-insensitive (uppercase from lowercase) completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## case-insensitive (all) completion
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
## case-insensitive,partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
setopt COMPLETE_IN_WORD # Allow completion from within a word/phrase
setopt ALWAYS_TO_END # When completing from the middle of a word, move cursor to end of word
unsetopt MENU_COMPLETE # When using auto-complete, put the first option on the line immediately
setopt COMPLETE_ALIASES # Turn on completion for aliases as well
setopt LIST_ROWS_FIRST  # Cycle through menus horizontally instead of vertically
setopt NO_CASE_GLOB # Case insensitive globbing
setopt EXTENDED_GLOB # Allow the powerful zsh globbing features
setopt NUMERIC_GLOB_SORT # Sort globs that expand to numbers numerically, not by letter (i.e. 01 2 03)

# key bindings
bindkey '^r' history-incremental-pattern-search-backward

fpath=( "$HOME/dotfiles/zsh-themes/pure" $fpath )
autoload -U promptinit; promptinit
#PURE_GIT_PULL=0
if [ "$TERM" = "linux" ]; then
	PURE_PROMPT_SYMBOL="$"
fi
prompt pure

# Aliases
source $HOME/dotfiles/aliases

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/felix/.sdkman"
[[ -s "/home/felix/.sdkman/bin/sdkman-init.sh" ]] && source "/home/felix/.sdkman/bin/sdkman-init.sh"
