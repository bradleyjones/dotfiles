# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
PROMPT="%m ${PROMPT}"

########### User configuration ###########

# Bifrost / ansible
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
# GO PATH
export GOPATH=$HOME/src/go


export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
