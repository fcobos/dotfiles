#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[38;5;39m\]\u\[\e[0m\]@\[\e[38;5;208m\]\H \[\e[38;5;39m\]\W \[\e[38;5;39m\]$ \[\e[0;0m\]'

eval `dircolors /etc/DIR_COLORS`
# Aliases
alias ls='ls --color=auto' 2>/dev/null
alias ll='ls -alF' 2>/dev/null
alias la='ls -A' 2>/dev/null
alias l.='ls -d .*' 2>/dev/null
alias l='ls -CF' 2>/dev/null
alias grep='grep --color=auto' 2>/dev/null
alias egrep='egrep --color=auto' 2>/dev/null
alias fgrep='fgrep --color=auto' 2>/dev/null
alias xzgrep='xzgrep --color=auto' 2>/dev/null
alias xzegrep='xzegrep --color=auto' 2>/dev/null
alias xzfgrep='xzfgrep --color=auto' 2>/dev/null
alias zgrep='zgrep --color=auto' 2>/dev/null
alias zfgrep='zfgrep --color=auto' 2>/dev/null
alias zegrep='zegrep --color=auto' 2>/dev/null
alias vi='vim' 2>/dev/null

# History control
export HISTSIZE=2000
export HISTCONTROL=erasedups:ignoreboth
export HISTIGNORE="history *:df *:exit:fg:bg:ll:ls:la:l.:l:cd:top:htop:glances:free *:clear"
#avoid overwriting history
#[ $SHELL = "/bin/bash" ]; shopt -s histappend

# gcc colors
export GCC_COLORS=error="01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/felix/.sdkman"
[[ -s "/home/felix/.sdkman/bin/sdkman-init.sh" ]] && source "/home/felix/.sdkman/bin/sdkman-init.sh"
