#!/usr/bin/env sh

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

echo "thanks for installing jcderr/workspace"

if [ -x /usr/bin/apt-get ]; then
    sudo apt-get -qq update
    sudo apt-get install -y git-core build-essential vim python-setuptools \
        python-pip python-virtualenv ruby rake rubygems ruby-dev ctags \
        nano zsh 
fi

# Backup existing .vim stuff
echo "backing up current vim config\n"
for i in ~/.vim ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done


echo "cloning jcderr/workspace\n"
git clone --recursive https://github.com/jcderr/workspace.git ~/.devenv
ln -s ~/.devenv/vimrc ~/.vimrc
ln -s ~/.devenv/vim ~/.vim

