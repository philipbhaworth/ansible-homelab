# ====================
# My .bashrc file
# Description: Configuration file for bash shell settings including environment paths, history control, and an enhanced Git prompt.
# ====================
# ~~~~~~~~~~~~~~~ Basic Setup ~~~~~~~~~~~~~~~~~~~~~~~~
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ~~~~~~~~~~~~~~~ Path Configuration ~~~~~~~~~~~~~~~~~~~~~~~~
# Add user-specific paths
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$HOME/.local/opt/nvim-linux64/bin"
export PATH="$PATH:$HOME/opt"

# ~~~~~~~~~~~~~~~ History Control ~~~~~~~~~~~~~~~~~~~~~~~~
# ignoreboth = ignoredups + ignorespace
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=5000                  # Increased history size
HISTFILESIZE=10000             # Increased file size
HISTTIMEFORMAT="%F %T "        # Add timestamps to history
HISTIGNORE="ls:ll:cd:pwd:exit:clear"  # Don't record common commands
shopt -s checkwinsize

# ~~~~~~~~~~~~~~~ Less Setup ~~~~~~~~~~~~~~~~~~~~~~~~
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
force_color_prompt=yes

# ~~~~~~~~~~~~~~~ Prompt Configuration ~~~~~~~~~~~~~~~~~~~~~~~~
# Color codes
RED="\\[\\e[1;31m\\]"
GREEN="\\[\\e[1;32m\\]"
YELLOW="\\[\\e[1;33m\\]"
BLUE="\\[\\e[1;34m\\]"
MAGENTA="\\[\\e[1;35m\\]"
CYAN="\\[\\e[1;36m\\]"
WHITE="\\[\\e[1;37m\\]"
ENDC="\\[\\e[0m\\]"

# Git branch in prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Set a two-line prompt. If accessing via ssh, include 'ssh-session' message.
if [[ -n "$SSH_CLIENT" ]]; then ssh_message="-ssh_session"; fi
PS1="${MAGENTA}\t ${GREEN}\u ${WHITE}@ ${YELLOW}\h${RED}${ssh_message} ${WHITE}in ${BLUE}\w ${CYAN}\$(parse_git_branch)\n${CYAN}❯${ENDC} "

# Terminal title (optional)
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~
# File management
alias ls='ls -lh --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -a --color=auto'
alias l='ls -lbGF --color=auto'
alias lld='ls -lah --color=auto --group-directories-first'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Misc
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias mkdir='mkdir -pv'
alias c='clear'
alias tree='tree -C'
alias df='df -h'                          # Human-readable sizes
alias free='free -m'                      # Show sizes in MB
alias ip='ip --color=auto'
alias path='echo -e ${PATH//:/\\n}'       # Print each PATH entry on a new line

# Safety nets
alias rm='rm -i'                          # Confirm before removing
alias cp='cp -i'                          # Confirm before overwriting
alias mv='mv -i'                          # Confirm before overwriting

# Notification for long-running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]+\s*//;s/[;&|]\s*alert$//'\'')"'

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~
# Extract various archive formats
extract() {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar e "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Make a directory and change to it
mkcd() { mkdir -p "$1" && cd "$1"; }

# ~~~~~~~~~~~~~~~ Additional Configurations ~~~~~~~~~~~~~~~~~~~~~~~~
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# ~~~~~~~~~~~~~~~ Programmable Completion ~~~~~~~~~~~~~~~~~~~~~~~~
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~
export TERM=xterm
export EDITOR=vim
export VISUAL=vim
# For less/man pages
export LESS="-R"
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
