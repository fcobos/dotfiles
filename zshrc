# History
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HIST_STAMPS="yyyy-mm-dd"
SAVEHIST=10000
HISTSIZE=50000
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt append_history
setopt hist_reduce_blanks

setopt ZLE
unsetopt NO_HUP
setopt INTERACTIVE_COMMENTS

# ls colors
eval $(dircolors)

# Autoload auto completion
autoload -U compinit
compinit -i
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
unsetopt MENU_COMPLETE
setopt COMPLETE_ALIASES
setopt LIST_ROWS_FIRST
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT

# key bindings
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init() {
		echoti smkx
	}
	function zle-line-finish() {
		echoti rmkx
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi

bindkey -e # Use emacs key bindings
#bindkey -v # vim keybindings

bindkey '\ew' kill-region
bindkey -s '\el' 'ls\n'
bindkey '^r' history-incremental-search-backward
if [[ "${terminfo[kpp]}" != "" ]]; then
	bindkey "${terminfo[kpp]}" up-line-or-history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
	bindkey "${terminfo[knp]}" down-line-or-history
fi

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

if [[ "${terminfo[khome]}" != "" ]]; then
	bindkey "${terminfo[khome]}" beginning-of-line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
	bindkey "${terminfo[kend]}"  end-of-line
fi

bindkey ' ' magic-space

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

if [[ "${terminfo[kcbt]}" != "" ]]; then
	bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

bindkey '^?' backward-delete-char
if [[ "${terminfo[kdch1]}" != "" ]]; then
	bindkey "${terminfo[kdch1]}" delete-char
else
	bindkey "^[[3~" delete-char
	bindkey "^[3;5~" delete-char
	bindkey "\e[3~" delete-char
fi

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# file rename magick
bindkey "^[m" copy-prev-shell-word

fpath=( "$HOME/dotfiles/zsh-themes/pure" $fpath )
autoload -U promptinit; promptinit
PURE_GIT_PULL=0
if [ "$TERM" = "linux" ]; then
	PURE_PROMPT_SYMBOL="$"
fi
PURE_GIT_UP_ARROW="↑"
PURE_GIT_DOWN_ARROW="↓"
prompt pure
# Show number of background jobs
PROMPT='%(1j.[%j] .)%(?.%F{green}.%F{red})${PURE_PROMPT_SYMBOL:-❯}%f '

# Aliases
source $HOME/dotfiles/aliases

# termite needs this
source /etc/profile.d/vte.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/felix/.sdkman"
[[ -s "/home/felix/.sdkman/bin/sdkman-init.sh" ]] && source "/home/felix/.sdkman/bin/sdkman-init.sh"
