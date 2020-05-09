#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1=$'\[\e[38;5;39m\]\u\[\e[0m\]@\[\e[38;5;208m\]\H \[\e[38;5;39m\]\W
\[\e[38;5;39m\]$ \[\e[0;0m\]'
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty*|tmux*|screen*|st*)
		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
		;;
esac

# Aliases
source $HOME/dotfiles/aliases

# History control
export HISTSIZE=10000
export HISTCONTROL=erasedups:ignoreboth
export HISTIGNORE="history *:df *:exit:fg:bg:ll:ls:la:l.:l:cd:top:htop:glances:free *:clear"
#avoid overwriting history
#[ $SHELL = "/bin/bash" ]; shopt -s histappend

# ls colors
eval $(dircolors ~/.dircolors)

# case insensitive tab completion
bind "set completion-ignore-case on"

set colored-stats on
set completion-ignore-case on
set skip-completed-text on

# vim keybindings
#set -o vi

# pipenv config
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

# https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
