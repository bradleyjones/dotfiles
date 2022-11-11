# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git docker alias-finder brew common-aliases docker-compose git-auto-fetch golang history helm kubectl man pip pyenv pylint python copyfile zsh-autosuggestions)
#plugins=(git zsh-iterm-touchbar vi-mode)
source $ZSH/oh-my-zsh.sh

########### User configuration ###########

# Show Hostname
#PROMPT="%m ${PROMPT}"
# GO PATH
export GOROOT=/usr/local/go
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH:$GOROOT/bin
export LC_ALL=en_GB.UTF-8
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
# GPG support password pop up for tagging
export GPG_TTY=$(tty)
# Disable shared history across terminals
setopt no_share_history
export HISTCONTROL=ignoreboth
# Fix tmux on remote server using termite
export TERM=xterm-256color
# Allow go get to accept input
export GIT_TERMINAL_PROMPT=1

# WORK Dev settings
export DOCKER_BUILD=true

# Load venv
#export VIRTUAL_ENV_DISABLE_PROMPT=1
#source ~/.venv/bin/activate

# Fix DYLD path for networking-cisco UTs
#export DYLD_FALLBACK_LIBRARY_PATH=/usr/lib

# Zsh history search
bindkey '\eOA' history-beginning-search-backward
bindkey '\e[A' history-beginning-search-backward
bindkey '\eOB' history-beginning-search-forward
bindkey '\e[B' history-beginning-search-forward

export PATH=$PATH:/home/bradley/.go/bin

export PATH=$PATH:/home/bradley/go/bin

# Custom aliases
source ~/.aliases
export PATH="/usr/local/sbin:$PATH"

source ~/.anchore-secrets
export PATH="/opt/homebrew/opt/go@1.18/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
