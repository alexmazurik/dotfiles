#!/bin/sh -eu

HOSTS=$*

for host in $HOSTS; do
    echo Occupying $host
    ssh $host "curl https://raw.githubusercontent.com/alexmazurik/dotfiles/master/install_latest.sh | sh"
done
