# ====================
# Minimal .bashrc for utility nodes
# ====================

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Path Configuration
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# History Control
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=500
HISTFILESIZE=1000
shopt -s checkwinsize

# Simple prompt with hostname (shows ssh connection)
if [[ -n "$SSH_CLIENT" ]]; then
    PS1="\[\e[1;33m\]\h\[\e[0m\][\[\e[1;36m\]\w\[\e[0m\]]\$ "
else
    PS1="\[\e[1;32m\]\h\[\e[0m\][\[\e[1;36m\]\w\[\e[0m\]]\$ "
fi

# Core aliases
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'

# Load bash completion if available
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Set terminal type
export TERM=xterm
