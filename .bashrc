OS=`uname`

if [ "$OS" == "Darwin" ]; then
  source /Users/bradley/.rvm/scripts/rvm
fi

EDITOR=vim
PS1='\w \u\$ '

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

function say { mplayer -really-quiet "http://translate.google.com/translate_tts?tl=en&q=$1"; }
