all: bin cli desktop


bin:
	mkdir $(HOME)/bin
	ln -sf $(CURDIR)/bin/* $(HOME)/bin


cli: shell tmux vim git

shell:
	$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)
	ln -sf $(CURDIR)/.zshrc $(HOME)/.zshrc
	ln -sf $(CURDIR)/.aliases $(HOME)/.aliases

tmux:
	ln -sf $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf
	ln -sf $(CURDIR)/.tmux-airline $(HOME)/.tmux-airline

vim:
	mkdir -p $(HOME)/.vim/autoload
	ln -sf $(CURDIR)/.vimrc $(HOME)/.vimrc
	vim +PlugInstall +qall
	pip3 install --upgrade neovim # Required for deoplete

git:
	ln -sf $(CURDIR)/.gitconfig ~/.gitconfig
	

desktop: i3 xresrouces keyboard fonts

i3:
	mkdir $(HOME)/.i3
	ln -sf $(CURDIR)/.i3/* $(HOME)/.i3/

xresources:
	ln -sf $(CURDIR)/.Xresources $(HOME)/.Xresources
	ln -sf $(CURDIR)/.xinitrc $(HOME)/.xinitrc

keyboard:
	ln -sf $(CURDIR)/.xmodmaprc $(HOME)/.xmodmaprc

fonts:
	sudo ln -sf $(CURDIR)/etc/fonts/local.conf /etc/fonts/local.conf
	mkdir -p $(HOME)/.local/share/fonts
	ln -sf $(CURDIR)/.fonts/* $(HOME)/.local/share/fonts/
