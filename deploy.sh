#!/bin/sh -e

echo Make symlinks on dotfiles
for f in $HOME/.dotfiles/.*; do
    [ -f "$f" ] || continue
    link=$HOME/`basename "$f"`
    rm -f "$link"
    ln -sf $f "$link"
done
