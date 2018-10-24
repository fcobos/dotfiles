#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[38;5;39m\]\u\[\e[0m\]@\[\e[38;5;208m\]\H \[\e[38;5;39m\]\W
\[\e[38;5;39m\]$ \[\e[0;0m\]'
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty*)
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

# termite needs this
source /etc/profile.d/vte.sh

# vim keybindings
#set -o vi

# pipenv config
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/felix/.sdkman"
[[ -s "/home/felix/.sdkman/bin/sdkman-init.sh" ]] && source "/home/felix/.sdkman/bin/sdkman-init.sh"
