#!/bin/sh -eu

HOST=$1

echo "Cloning .dotfiles"
scp -r "$HOME/.dotfiles" "$HOST:"

echo "Deploy"
ssh "$HOST" '$HOME/.dotfiles/deploy.sh'
