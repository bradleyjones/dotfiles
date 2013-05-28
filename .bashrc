OS=`uname`

if [ "$OS" == "Darwin" ]; then
  source /Users/bradley/.rvm/scripts/rvm
fi

PS1='┌─[\e[0;31m\u\e[m]-[\e[0;34m\w\e[m]\e[0;35m$( git_branch )\e[m\n└─╼ '

# funky clear
alias clear='clear; l; echo;'

# colour ls aliases
alias ll='ls -Glhfa'
alias la='ls -Gaf'
alias l='ls -GCF'

alias pi='ssh pi@24.23.164.236'

alias gc='python ~/Programming/Git-Journal/Git-Journal.py -r'
alias todo='python ~/Programming/terminal-todo/todo.py'

### Functions

# Search current directory recursively for filenames containing $@
search () {
  /usr/bin/find . -name "*$@*"
}

# cd clears the terminal every use
cd () {
  builtin cd "$@"
  clear
}

function myip { curl ifconfig.me; }

function say { mplayer -really-quiet "http://translate.google.com/translate_tts?tl=en&q=$1"; }

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/-[\1$(parse_git_dirty)]/" || return;
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
