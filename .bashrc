# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


PS1="\[\033[38;5;26m\]\w\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;242m\]>\[$(tput sgr0)\] \[$(tput sgr0)\]"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Utility functions

# Join bash arrays with a single character delimeter.
function join_by() {
    local IFS="$1";
    shift;
    echo "$*";
}

# Configure PATH variable
paths=(
    "$HOME/.go/bin"
    "$HOME/.toolbox/bin"
    "$HOME/.bin"
    "$(brew --prefix coreutils)/libexec/gnubin"
    "$(brew --prefix findutils)/libexec/gnubin"
    "$(brew --prefix gnu-sed)/libexec/gnubin"
    "$(brew --prefix gnu-tar)/libexec/gnubin"
    "$(brew --prefix gnu-which)/libexec/gnubin"
    "$(brew --prefix grep)/libexec/gnubin"
    "$(brew --prefix make)/libexec/gnubin"
    "$PATH"
)
export PATH=$(join_by : ${paths[@]})

# Configure MANPATH variable
manpaths=(
    "$(brew --prefix coreutils)/libexe/gnuman"    
    "$(brew --prefix findutils)/libexec/gnuman"
    "$(brew --prefix gnu-sed)/libexec/gnuman"
    "$(brew --prefix gnu-tar)/libexec/gnuman"
    "$(brew --prefix gnu-which)/libexec/gnuman"
    "$(brew --prefix grep)/libexec/gnuman"
    "$(brew --prefix make)/libexec/gnuman"
    "$(brew --prefix gzip)/share/man"
    "$(brew --prefix diffutils)/share/man"
    "$(brew --prefix binutils)/share/man"
    "$(brew --prefix watch)/share/man"
    "$(brew --prefix screen)/share/man"
    "$(brew --prefix wdiff)/share/man"
    "$(brew --prefix wget)/share/man"
    "$(brew --prefix m4)/share/man"
    "$(brew --prefix rsync)/share/man"
    "$(brew --prefix openssh)/share/man"
    "$(brew --prefix unzip)/share/man"
    "$MANPATH"
)
export MANPATH=$(join_by : ${manpaths[@]})

# Configure Golang env
export GOPROXY="https://goproxy.eks-anywhere.model-rocket.aws.dev"
export GOPATH="$(go env GOPATH)"

# Alias'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
