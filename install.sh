#!/usr/bin/env bash

installHomebrew(){
    echo Installing \"Homebrew\" ...
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

setGit(){
    echo Setting \".gitconfig\" ...
    ln -fs `pwd`/Git/gitconfig ~/.gitconfig
}

setVim(){
    echo Setting \".vimrc\" ...
    ln -fs `pwd`/Vim/vimrc ~/.vimrc
    echo

    echo Installing vundle ...
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim +PluginInstall +qall

    echo Setting \"snipmate\" ...
    for snippet in $(ls `pwd`/SnipMate/)
    do
        ln -fs `pwd`/SnipMate/$snippet ~/.vim/snippets/$snippet
    done
}

setTmux(){
    echo Setting \".tmux.conf\" ...
    ln -fs `pwd`/Tmux/tmux.conf ~/.tmux.conf
}

setZsh(){
    echo Setting \".zshrc\" ...
    ln -fs `pwd`/Zsh/zshrc ~/.zshrc
}

until [ "$SETTING_TARGET" == "q" ]
do
    echo "Select the dotfiles to be set."
    echo "1) All (including git, vim, tmux, zsh)"
    echo "2) Git"
    echo "3) Vim"
    echo "4) Tmux"
    echo "5) Zsh"
    echo "6) Homebrew"
    echo "(Enter or type q to quit)"
    echo

    read -p "Setting target: " SETTING_TARGET
    SETTING_TARGET=${SETTING_TARGET:-"q"}
    echo

    case $SETTING_TARGET in
        "1")
            installHomebrew; setGit; setVim; setTmux; setZsh
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
        "6")
            installHomebrew
            ;;
        "q")
            ;;
        *)
            echo "Invalid Operation!!"
            ;;
    esac
done
