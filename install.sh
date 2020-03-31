#!/usr/bin/env bash

setEnvVar() {
    OS=$(uname -s)
    if [ "$OS" == "Linux" ]; then
        PKG_UPDATE="sudo apt-get update"
        PKG_INSTALL="sudo apt-get install"
    else
        PKG_UPDATE="brew update"
        PKG_INSTALL="brew install"
    fi

    PIP_INSTALL="pip3 install"
}


installHomebrew() {
    echo Installing \"Homebrew\" ...
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

installRequirements() {
    if [ "$OS" != "Linux" ]; then
        installHomebrew
    fi

    $PKG_UPDATE
    $PKG_INSTALL git zsh tmux cscope ctags cppcheck clang-format gnuplot aspell trash-cli

    if [ "$OS" == "Linux" ]; then
        $PKG_INSTALL build-essential vim-gnome python3-pip valgrind curl wget
        $PIP_INSTALL youtube-dl
    else
        $PKG_INSTALL python3 vim youtube-dl
    fi
}

init() {
    echo "set completion-ignore-case on" >> ~/.inputrc
    sudo timedatectl set-local-rtc 1 --adjust-system-clock

    setEnvVar
    installRequirements
}

setGit() {
    echo Setting \".gitconfig\" ...
    ln -fs `pwd`/Git/gitconfig ~/.gitconfig
}

setVim() {
    echo "Setting \".vimrc\" ..."
    ln -fs `pwd`/Vim/vimrc ~/.vimrc

    echo -e "\nInstalling vundle ..."
    #git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

    echo Setting \"snipmate\" ...
    for snippet in $(ls `pwd`/SnipMate/)
    do
        ln -fs `pwd`/SnipMate/$snippet ~/.vim/snippets/$snippet
    done
}

setTmux() {
    echo Setting \".tmux.conf\" ...
    ln -fs `pwd`/Tmux/tmux.conf ~/.tmux.conf
}

setZsh() {
    echo -e "Switch shell to zsh ..."
    chsh -s /usr/bin/zsh

    echo -e "\n Installing oh-my-zsh ..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    echo -e "\n Installing powerlevel9k ..."
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

    echo -e "\n Installing Nerd-Fonts ..."
    git clone https://github.com/ryanoasis/nerd-fonts.git ~/.fonts/nerd-fonts/
    ~/.fonts/nerd-fonts/install.sh

    echo -e "\nSetting \".zshrc\" ..."
    ln -fs `pwd`/Zsh/zshrc ~/.zshrc
    source ~/.zshrc
}


while true
do
    echo "Select the Configuration below:"
    echo "1) All settings"
    echo "2) Git"
    echo "3) Vim"
    echo "4) Tmux"
    echo "5) Zsh"
    echo -e "(Enter or type \"quit\" to exit)\n"

    read -p "Setting target: " SELECTION
    SELECTION=${SELECTION:-"q"}
    echo

    case $SELECTION in
        "q" | "qu" | "qui" | "quit")
            break
    esac

    echo "Install Requirements? Y/[N]"
    read INITIALIZE
    INITIALIZE=${INITIALIZE:-"N"}
    if [ "$INITIALIZED" == "Y" ] || [ "$INITIALIZED" == "YES" ]; then
        REQUIREMENTS_INSTALLED="N"
        echo "First, installing requirements ..."
        init
    fi

    case $SELECTION in
        "1")
            setGit; setVim; setTmux; setZsh
            break
            ;;
        "2")
            setGit
            ;;
        "3")
            setVim
            ;;
        "4")
            setTmux
            ;;
        "5")
            setZsh
            ;;
        "q" | "qu" | "qui" | "quit")
            break;
            ;;
        *)
            echo "Invalid Operation!!"
            ;;
    esac
done
