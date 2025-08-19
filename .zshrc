# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi 

# Pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
	colored-man-pages
	docker
	docker-compose
	git-auto-fetch
	gh
	golang
	helm
	kubectl
	minikube
	mosh
	pip
	poetry
	pyenv
	pylint
	vi-mode
 	zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

########### User configuration ###########

export LC_ALL=en_GB.UTF-8
export EDITOR='nvim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
# GPG support password pop up for tagging
export GPG_TTY=$(tty)
# Disable shared history across terminals
setopt no_share_history
export HISTCONTROL=ignoreboth
# Fix tmux on remote server using termite
# export TERM=xterm-256color
# Allow go get to accept input
export GIT_TERMINAL_PROMPT=1

# Load venv
#export VIRTUAL_ENV_DISABLE_PROMPT=1
#source ~/.venv/bin/activate

# Custom aliases
source ~/.aliases
export PATH="/usr/local/sbin:$PATH"

# Secrets
source ~/.anchore-secrets
source ~/.secrets

case `uname` in
  Darwin)
    # commands for OS X go here
    export GOPATH=/Users/bradley/go
    export GOROOT=/opt/homebrew/opt/go@1.22/libexec
    # export GOROOT=/opt/homebrew/opt/go@1.21/libexec
    # export GOROOT=/opt/homebrew/opt/go@1.20/libexec
    export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH:$GOROOT/bin:$GOPATH/bin
    export PATH="/opt/homebrew/opt/go@1.22/bin:$PATH"
    # export PATH="/opt/homebrew/opt/go@1.21/bin:$PATH"
    # export PATH="/opt/homebrew/opt/go@1.20/bin:$PATH"
  ;;
  Linux)
    # commands for Linux go here
    export PATH=$PATH:/usr/local/go/bin:$HOME/.local/bin
	export GOPATH=$HOME/go
	export GOBIN=$GOPATH/bin
  ;;
esac

# GPG
export GPG_TTY=$(tty)
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

# Ctrl+j to accept autosuggestions
bindkey '^j' autosuggest-accept

# Enable vi mode
bindkey -v
MODE_INDICATOR="%F{white}N%f"
INSERT_MODE_INDICATOR="%F{yellow}I%f"
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

export WEECHAT_HOME=~/.weechat
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Prompt
# Show Hostname
#PROMPT="%m ${PROMPT}"
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"

# p10k instant prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export TERM="xterm-256color"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
