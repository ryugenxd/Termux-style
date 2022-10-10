[[ $- != *i* ]] && return

shopt -s checkwinsize
shopt -s cmdhist
shopt -s globstar
shopt -s histappend
shopt -s histverify

## Configure bash history.
if [ "$(id -u)" = "0" ]; then
	export HISTFILE="$HOME/.bash_root_history"
else
	export HISTFILE="$HOME/.bash_history"
fi
export HISTSIZE=4096
export HISTFILESIZE=16384
export HISTCONTROL="ignoreboth"

## cursor
printf '\e[4 q'

## Prompt.
screenfetch -A EuroLinux
PROMPT_DIRTRIM=2
	PS1="
\[\033[0;31m\]┌─[\[\033[1;34m\]root\[\033[1;33m\]@\[\033[1;36m\]Username\[\033[0;31m\]]─[\[\033[0;32m\]\w\[\033[0;31m\]]
\[\033[0;31m\]└──╼ \[\e[1;31m\]❯\[\e[1;34m\]❯\[\e[1;90m\]❯\[\033[0m\] "

## Colorful output & useful aliases for 'ls' and 'grep'.
if [ -x "$PREFIX/bin/dircolors" ] && [ -n "$LOCAL_PREFIX" ]; then
	if [ -f "$LOCAL_PREFIX/etc/dircolors.conf" ]; then
		eval "$(dircolors -b "$LOCAL_PREFIX/etc/dircolors.conf")"
	fi
fi

## Colored output.
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto -h'

## Replace 'cat' with 'bat' (if available).
if [ -n "$(command -v bat)" ]; then
	alias cat='bat --color=never --decorations=never --paging=never'
fi

## Replace 'ls' with 'exa' (if available) + some aliases.
if [ -n "$(command -v exa)" ]; then
	alias l='exa'
	alias ls='exa'
	alias l.='exa -d .*'
	alias la='exa -a'
	alias ll='exa -Fhl'
	alias ll.='exa -Fhl -d .*'
else
	alias l='ls --color=auto'
	alias ls='ls --color=auto'
	alias l.='ls --color=auto -d .*'
	alias la='ls --color=auto -a'
	alias ll='ls --color=auto -Fhl'
	alias ll.='ls --color=auto -Fhl -d .*'
fi

## Safety.
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -i'
