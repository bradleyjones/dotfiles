install-ubuntu:
	sudo sed -e 's/$/ universe/' -i /etc/apt/sources.list
	add-apt-repository ppa:keithw/mosh-dev
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	apt update
	apt install \
		tmux \
		vim \
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
		mosh \
		jq \
		language-pack-en
	wget https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb
	dpkg -i bat_0.9.0_amd64.deb
	rm bat_0.9.0_amd64.deb
	usermod -aG docker bradley

comms:
	yay -S --noconfirm \
		weechat \
		neomutt \
		mbsync \
		msmtp

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
		davmail \
		feh \
		dunst \
		blueman \
		pulseaudio \
		ttf-ubuntu-font-family \
		ttf-font-awesome \
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
		syncthing-gtk




all: bin cli desktop


bin:
	mkdir $(HOME)/bin
	ln -sf $(CURDIR)/bin/* $(HOME)/bin


cli: shell tmux vim git bin

shell:
	which curl || ( echo 'curl is required, please install it' && exit 1 )
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
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

vim:
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
