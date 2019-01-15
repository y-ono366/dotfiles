#!/bin/bash

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    mv $HOME/$f "$HOME/$f.bk"
    cp $HOME/dotfiles/$f $HOME/$f
done
