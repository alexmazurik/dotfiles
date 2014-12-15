#!/bin/sh -e

cd $HOME

echo Get latest version
if type git >/dev/null 2>&1; then
    echo git available
    if [ ! -d .dotfiles ]; then
        git clone git@github.com:alexmazurik/dotfiles.git .dotfiles
    fi
    cd .dotfiles && git pull origin master
    DOTFILES=$(git ls-tree -r master --name-only | grep -v ".sh\$")
else
    echo "git unavailable -- use wget"
    wget https://github.com/alexmazurik/dotfiles/archive/master.tar.gz \
        -O /dev/stdout 2>/dev/null | \
    tar xzv --transform s/dotfiles-master/.dotfiles/
    cd .dotfiles
    DOTFILES=$(find . -type f ! -name "*sh" | grep -o ".[a-z].*")
fi

echo $DOTFILES

echo Make symlinks on dotfiles
for f in $DOTFILES; do
    [ -f "$f" ] || continue
    link=$HOME/"$f"
    rm -f "$link"
    ln -sfv $(readlink -m $f) "$link" || true
done
