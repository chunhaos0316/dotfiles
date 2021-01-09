#!/bin/env bash


PKG_UPDATE="sudo apt-get update"
PKG_UPGRADE="sudo apt-get upgrade"
PKG_INSTALL="sudo apt-get install"


function install_requirements()
{
	$PKG_UPDATE && $PKG_UPGRADE
	$PKG_INSTALL vim-gtk3 tmux zsh cscope ctags trash-cli openssh-client openssh-server \
                 build-essential python3-pip curl wget net-tools mlocate
}

function init()
{
	echo "set completion-ignore-case on" > ~/.inputrc
	sudo timedatectl set-local-rtc 1 --adjust-system-clock
}

function set_gitconfig()
{
	echo ">>> Setting \".gitconfig\""
	ln -fs $ROOT_DIR/Git/gitconfig ~/.gitconfig
}

function set_vim()
{
	echo ">>> Setting \".vimrc\""
	ln -fs $ROOT_DIR/Vim/vimrc ~/.vimrc

	[ -d "$HOME/.vim/bundle/Vundle.vim" ] || ( echo ">>> Installing Vundle" \
        && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
        && vim +PluginInstall +qall )

	echo ">>> Setting Snippets"
	[ -d "$HOME/.vim/snippets" ] || mkdir -p ~/.vim/snippets
	for snippet in $(ls $ROOT_DIR/SnipMate/)
	do
		ln -fs $ROOT_DIR/SnipMate/$snippet ~/.vim/snippets/$snippet
	done
}

function set_tmux()
{
	echo ">>> Setting \".tmux.conf\""
	ln -fs $ROOT_DIR/Tmux/tmux.conf ~/.tmux.conf
}

function set_zsh()
{
	[ "$SHELL" == "/usr/bin/zsh" ] || ( echo ">>> Switching current shell to \"zsh\"" \
        && chsh -s /usr/bin/zsh )

	[ -d "$HOME/.oh-my-zsh" ] || ( echo ">>> Installing oh-my-zsh" \
        && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" )

	[ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel9k" ] || ( echo ">>> Installing powerlevel9k" \
        && git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k )

	[ -d "$HOME/.fonts/nerd-fonts" ] || ( echo ">>> Installing Nerd-Fonts" \
        && git clone https://github.com/ryanoasis/nerd-fonts.git ~/.fonts/nerd-fonts/ \
        && ~/.fonts/nerd-fonts/install.sh )

	echo ">>> Setting \".zshrc\""
	ln -fs $ROOT_DIR/Zsh/zshrc ~/.zshrc
}

function main()
{
	init
	install_requirements
	set_gitconfig
	set_vim
	set_tmux
    set_zsh
}


main
