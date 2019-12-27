#!/usr/bin/env bash

setGit(){
    echo Setting \".gitconfig\" ...
    ln -fs `pwd`/Git/gitconfig ~/.gitconfig
}

setVim(){
    echo Setting \".vimrc\" ...
    ln -fs `pwd`/Vim/vimrc ~/.vimrc
}

setTmux(){
    echo Setting \".tmux.conf\" ...
    ln -fs `pwd`/Tmux/tmux.conf ~/.tmux.conf
}

setZsh(){
    echo Setting \".zshrc\" ...
    ln -fs `pwd`/Zsh/zshrc ~/.zshrc
}

echo "Select the dotfiles to be set."
echo "1) All (including git, vim, tmux, zsh)"
echo "2) Git"
echo "3) Vim"
echo "4) Tmux"
echo "5) Zsh"
echo "(type q to quit)"
echo

read -p "Setting target: " SETTING_TARGET
SETTING_TARGET=${SETTING_TARGET:-"q"}
echo

case $SETTING_TARGET in
    "1")
        setGit; setVim; setTmux; setZsh
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
    "q")
        ;;
    *)
        echo "Invalid Operation!!"
        ;;
esac
