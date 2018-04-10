# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git vi-mode)
#plugins=(git zsh-iterm-touchbar vi-mode)
source $ZSH/oh-my-zsh.sh

########### User configuration ###########

# Show Hostname
#PROMPT="%m ${PROMPT}"
# Bifrost / ansible
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
# GO PATH
export GOPATH=$HOME/src/go
export LC_ALL=en_GB.UTF-8
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
# GPG support password pop up for tagging
export GPG_TTY=$(tty)

# Load venv
export VIRTUAL_ENV_DISABLE_PROMPT=1
source ~/.venv/bin/activate

# Fix DYLD path for networking-cisco UTs
#export DYLD_FALLBACK_LIBRARY_PATH=/usr/lib

# Zsh history search
bindkey '\eOA' history-beginning-search-backward
bindkey '\e[A' history-beginning-search-backward
bindkey '\eOB' history-beginning-search-forward
bindkey '\e[B' history-beginning-search-forward
