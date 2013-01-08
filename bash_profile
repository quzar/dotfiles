export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
export PATH=~/Applications:~/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export NODEPATH=/usr/local/lib/node_modules
export P4PORT=172.17.112.24:1666
export P4CLIENT=dthompson1_MacBook_Pro
export SVN_EDITOR=vim

export HISTSIZE=3000
export HISTCONTROL=erasedups
export HISTIGNORE=ls:cd:pwd:exit::clear
shopt -s histappend

function pgrep() {
    ps aux | grep $1 | grep -v grep
}

function pkill() {
    local pid
    pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
    kill -9 $pid
    echo -n "Killed $1 (process $pid)"
}

alias events="/usr/local/bin/icalBuddy -f -sc -ss '' -eep 'notes,location' eventsNow"
alias eventsNow="/usr/local/bin/icalBuddy -f -sc -ss '' -eep 'notes,location' eventsNow"
alias eventsToday="/usr/local/bin/icalBuddy -f -sc -ss '' -eep 'notes,location' eventsToday"
alias diff="colordiff"

# Fancy coloured bash prompt
export PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# This prints the local host in the screen title. Used in conjunction with ssh_screen.sh
export PROMPT_COMMAND='history -a; if [ $TERM = "screen" ]; then printf "\033k${HOSTNAME%%.*}\033\\" ; fi' 
export GREP_OPTIONS="--exclude=\*.svn\*"
echo -ne "\033]0;$HOSTNAME\007"

# Allows you to send ctrl-s & ctrl-q to terminal applications
stty stop undef # unmap ctrl-s
stty start undef # unmap ctrl-q

