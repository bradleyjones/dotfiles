install-ubuntu:
	# sudo sed -e 's/$/ universe/' -i /etc/apt/sources.list
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable"
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
		bat
	#usermod -aG docker bradley

comms:
	yay -S --noconfirm \
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

yay: arch-pre
	cd /tmp && \
	git clone https://aur.archlinux.org/yay.git
	cd /tmp/yay && \-
	makepkg -si

yay-pre:
	sudo pacman -Sy --noconfirm vim git tmux zsh

install-arch:
	yay -S --noconfirm \
		xorg-xinit \
		xorg-server \
		xf86-video-intel \
		i3-gaps \
		i3blocks-git \
		chromium \
		termite \
		curl \
		python \
		python-pip \
		compton \
		bat \
		jq \
		feh \
		dunst \
		blueman \
		pulseaudio \
		ttf-ubuntu-font-family \
		ttf-font-awesome \
		ttf-ms-fonts \
		dmenu \
		pavucontrol \
		nextcloud-client \
		networkmanager \
		network-manager-applet \
		openssh \
		rsync \
		mosh \
		htop \
		syncthing \
		syncthing-gtk \
		tree \
		xsel \
		clipit \
		universal-ctags-git

all: bin cli desktop

bin:
	mkdir $(HOME)/bin
	ln -sf $(CURDIR)/bin/* $(HOME)/bin

cli: shell tmux vim git

$(~/.oh-my-zsh):
	which curl || ( echo 'curl is required, please install it' && exit 1 )
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

shell: $(~/.oh-my-zsh)
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
	curl -sL install-node.now.sh/lts | sudo bash
	pip3 install --user jedi

vim: vim-coc nvim-config
	which curl || ( echo 'curl is required, please install it' && exit 1 )
	which pip3 || ( echo 'pip3 is required, please install it' && exit 1 )
	mkdir -p $(HOME)/.vim/autoload
	ln -sf $(CURDIR)/.vimrc $(HOME)/.vimrc
	vim +PlugInstall +qall
	sudo pip3 install --upgrade neovim # Required for deoplete

git:
	ln -sf $(CURDIR)/.gitconfig ~/.gitconfig


desktop: i3 xresources keyboard fonts sounds termite

i3:
	mkdir -p $(HOME)/.i3
	ln -sf $(CURDIR)/.i3/* $(HOME)/.i3/

xresources:
	ln -sf $(CURDIR)/.Xresources $(HOME)/.Xresources
	ln -sf $(CURDIR)/.xinitrc $(HOME)/.xinitrc

termite:
	mkdir -p $(HOME)/.config/termite
	ln -sf $(CURDIR)/.termite-config $(HOME)/.config/termite/config

compton:
	mkdir -p $(HOME)/.config/compton
	ln -sf $(CURDIR)/.compton.conf $(HOME)/.config/compton/compton.conf

dunst:
	mkdir -p $(HOME)/.config/dunst
	ln -sf $(CURDIR)/.dunstrc $(HOME)/.config/dunst/dunstrc

khal:
	mkdir -p $(HOME)/.config/khal
	ln -sf $(CURDIR)/.khal-config $(HOME)/.config/khal/config

keyboard:
	ln -sf $(CURDIR)/.xmodmaprc $(HOME)/.xmodmaprc

fonts:
	# on arch install awesome-terminal-fonts
	sudo ln -sf $(CURDIR)/etc/fonts/local.conf /etc/fonts/local.conf
	mkdir -p $(HOME)/.local/share/fonts
	ln -sf $(CURDIR)/.fonts/* $(HOME)/.local/share/fonts/

sounds:
	sudo ln -sf $(CURDIR)/sounds $(HOME)/.sounds

gertty:
	cp $(CURDIR)/.gertty.yaml $(HOME)/.gertty.yaml
