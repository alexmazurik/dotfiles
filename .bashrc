

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace # append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
PS1='${debian_chroot:+($debian_chroot)}\[\033[00;31m\]\u\[\033[0;32m\]@\[\033[0;33m\]\h\[\033[00m\]:\[\033[00;34m\]\w\[\033[00;35m\]\$ \[\033[0m\]'
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias m='make -j'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# my alliases

alias rq="cd /home/almaz/m/routing/router-quality && ls -a"
alias ro="cd /home/almaz/m/routing/router/yacare && ls -a"
alias pm="git pull --rebase origin master && git push origin master && echo OK"
alias pm="git commit -am 'fix' && git cr pub"
alias adhara="go adhara"
alias chck="make clean && make test -j && echo 'OK'"
alias acp="apt-cache policy"
alias acs="apt-cache search"
alias ai="sudo apt-get install"
alias di="sudo dpkg -i"
alias h="history | grep"
alias e="vim"
alias f="find . -name"
alias updr="git add -u && git commit -m 'fix' && git cr pub"
export EMAIL="almaz@yandex-team.ru"
export DEBFULLNAME="Alexander Mazurik"
#PS1="\[\033[0;31m\]\u\[\033[0;32m\]@\[\033[0;33m\]\h:\[\033[0;35m\]\w$ \[\033[0m\]\[\033[0m\]"
function swap() {
    mv "$1" some_unused_name && mv "$2" "$1" &&  mv some_unused_name "$2"
}

function mkcd() {
    mkdir $1 && cd $1
}

function go() {
    ssh "$1".maps.dev.yandex.net
}

function scppath() {
    for path in "$@"
    do
        if [ ${path:0:1} != "/" ] ; then
            path=$(pwd)/${path}
        fi
        echo $(hostname):${path}
    done
}

function inv() {
    while [ $# -ge 2 ]; do
        echo -n "$2 $1 "
        shift 2
    done
    if [ $# -eq 1 ]; then
        echo -n "$1 "
    fi
}

function om() {
    TOOL=$1
    shift

    for i in $@; do
        man $TOOL | grep "\-\-$i" -A 10
    done
}

function hb() {
    ar p $1 2>/dev/null | tar -zxOf- ./sanebuild_cmdline
}

function dep() {
    PACKAGE=$1
    debtree $PACKAGE | dot -Tpng -o /home/almaz/debtree/$PACKAGE.png
}

PATH=/home/almaz/.local_packages/bin/:$PATH
PATH=$PATH:/usr/sbin/
export PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# set vi-mode
set -o vi

#exec zsh
