install-ubuntu:
	# sudo sed -e 's/$/ universe/' -i /etc/apt/sources.list
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
	apt update
	apt install \
		tmux \
		vim \
		neovim \
		zsh \
		wget \
		git \
		htop \
		exuberant-ctags \
		python-dev \
		python3-dev \
		python3-pip \
		ca-certificates \
		software-properties-common \
		docker-ce \
		docker-ce-cli \
		containerd.io \
		mosh \
		jq \
		language-pack-en \
		bat \
		fzf \
		ripgrep \
		nodejs npm # Used for vim-coc
	#usermod -aG docker bradley

comms:
	yay -S --noconfirm \
		slack-desktop \
		weechat \
		neomutt \
		mbsync \
		msmtp \
		aspell \
		guile2.0 \
		tcl \
		ruby \
		python2-websocket-client \
		khal \
		vdirsyncer \
		davmail \
		urlview \
		jp2a \
		w3m

yay: yay-pre
	cd /tmp && \
	git clone https://aur.archlinux.org/yay.git
	cd /tmp/yay && \
	makepkg -si

yay-pre:
	sudo pacman -S --needed git base-devel

# TODO decide on either i3blocks or i3status
install-arch:
	yay -S --noconfirm \
		xorg-xinit \
		xorg-server \
		xf86-video-intel \
		i3-gaps \
		i3blocks \
		i3status \
		termite \
		curl \
		wget \
		fzf \
		ripgrep \
		python \
		python-pip \
		picom \
		bat \
		jq \
		feh \
		dunst \
		lib-notify \
		blueman \
		pulseaudio \
		ttf-ubuntu-font-family \
		ttf-font-awesome \
		ttf-ms-fonts \
		ttf-symbola \
		dmenu \
		pavucontrol \
		openssh \
		rsync \
		mosh \
		htop \
		tree \
		xsel \
		clipit \
		vim \
		neovim \
		tmux \
		git \
		nodejs \
		arandr \
		man \
		docker \
		inetutils \
		universal-ctags-git

all: binaries cli desktop

binaries: $(home)/bin
	ln -sf $(CURDIR)/bin/* $(HOME)/bin/

$(HOME)/bin:
	mkdir $(HOME)/bin

macos: homebrew
	brew bundle

homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cli: shell tmux vim git

~/.oh-my-zsh:
	which wget || ( echo 'wget is required, please install it' && exit 1 )
	sh -c "$$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
	git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

shell: ~/.oh-my-zsh
	ln -sf $(CURDIR)/.zshrc $(HOME)/.zshrc
	ln -sf $(CURDIR)/.aliases $(HOME)/.aliases

tmux: tmux-plugins
	ln -sf $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf
	ln -sf $(CURDIR)/.tmux-airline $(HOME)/.tmux-airline

tmux-plugins:
	mkdir -p $(HOME)/.tmux-plugins
	@while read -r plugin; do \
		repo="$$plugin"; \
		dir="$(HOME)/.tmux-plugins/$${repo##*/}"; \
		if cd $$dir; then git pull; else git clone $$repo $$dir; fi; \
	done < $(CURDIR)/.tmux-plugins

nvim-config:
	mkdir -p $(HOME)/.config
	ln -sf $(CURDIR)/nvim $(HOME)/.config/nvim

vim-coc:
	pip3 install --user jedi

vim: vim-coc nvim-config
	which curl || ( echo 'curl is required, please install it' && exit 1 )
	which pip3 || ( echo 'pip3 is required, please install it' && exit 1 )
	mkdir -p $(HOME)/.vim/autoload
	ln -sf $(CURDIR)/.vimrc $(HOME)/.vimrc
	GOPATH=$(HOME) GOBIN=$(HOME)/bin vim +PlugInstall +qall
	sudo pip3 install --upgrade neovim # Required for deoplete

git:
	ln -sf $(CURDIR)/.gitconfig ~/.gitconfig


desktop: i3 xresources keyboard fonts copy-sounds termite screen-tear picom dunst

i3:
	mkdir -p $(HOME)/.i3
	ln -sf $(CURDIR)/.i3/* $(HOME)/.i3/

xresources:
	ln -sf $(CURDIR)/.Xresources $(HOME)/.Xresources
	ln -sf $(CURDIR)/.xinitrc $(HOME)/.xinitrc

termite:
	mkdir -p $(HOME)/.config/termite
	ln -sf $(CURDIR)/.termite-config $(HOME)/.config/termite/config

picom:
	mkdir -p $(HOME)/.config/picom
	ln -sf $(CURDIR)/.picom.conf $(HOME)/.config/picom/picom.conf

dunst:
	mkdir -p $(HOME)/.config/dunst
	ln -sf $(CURDIR)/.dunstrc $(HOME)/.config/dunst/dunstrc

khal:
	mkdir -p $(HOME)/.config/khal
	ln -sf $(CURDIR)/.khal-config $(HOME)/.config/khal/config

keyboard:
	ln -sf $(CURDIR)/.xmodmaprc $(HOME)/.xmodmaprc

screen-tear:
	sudo ln -sf $(CURDIR)/20-intel.conf /etc/X11/xorg.conf.d/20-intel.conf

fonts:
	# on arch install awesome-terminal-fonts
	sudo ln -sf $(CURDIR)/etc/fonts/local.conf /etc/fonts/local.conf
	mkdir -p $(HOME)/.local/share/fonts
	ln -sf $(CURDIR)/.fonts/* $(HOME)/.local/share/fonts/

copy-sounds:
	sudo ln -sf $(CURDIR)/sounds $(HOME)/.sounds

gertty:
	cp $(CURDIR)/.gertty.yaml $(HOME)/.gertty.yaml

pull-docker-containers:
	docker pull jiahaog/nativefier

# Ensure docker containers use systemd-resolved
docker-dns:
	echo 'nameserver 127.0.0.53' > /etc/resolv.conf
