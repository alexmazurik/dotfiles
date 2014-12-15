#!/bin/sh -eu

HOST=$1
echo Occupying $HOST

ssh $HOST "curl https://raw.githubusercontent.com/alexmazurik/dotfiles/master/install_latest.sh | sh"
