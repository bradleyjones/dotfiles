all: bin cli desktop


bin:
	mkdir $(HOME)/bin
	ln -s $(CURDIR)/bin/* $(HOME)/bin


cli: shell tmux vim git

shell:
	$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)
	ln -s $(CURDIR)/.zshrc $(HOME)/.zshrc
	ln -s $(CURDIR)/.aliases $(HOME)/.aliases

tmux:
	ln -s $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf
	ln -s $(CURDIR)/.tmux-airline $(HOME)/.tmux-airline

vim:
	mkdir -p $(HOME)/.vim/autoload
	ln -s $(CURDIR)/.vimrc $(HOME)/.vimrc
	vim +PlugInstall +qall

git:
	ln -s $(CURDIR)/.gitconfig ~/.gitconfig
	

desktop: i3 xresrouces keyboard fonts

i3:
	mkdir $(HOME)/.i3
	ln -s $(CURDIR)/.i3/* $(HOME)/.i3/

xresources:
	ln -s $(CURDIR)/.Xresources $(HOME)/.Xresources
	ln -s $(CURDIR)/.xinitrc $(HOME)/.xinitrc

keyboard:
	ln -s $(CURDIR)/.xmodmaprc $(HOME)/.xmodmaprc

fonts:
	sudo ln -s $(CURDIR)/etc/fonts/local.conf /etc/fonts/local.conf
	mkdir -p $(HOME)/.local/share/fonts
	ln -s $(CURDIR)/.fonts/* $(HOME)/.local/share/fonts/
