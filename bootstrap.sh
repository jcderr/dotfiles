#!/usr/bin/env sh

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

if [ -x /usr/bin/apt-get ]; then
    sudo apt-get -qq update
    sudo apt-get install -y git-core build-essential vim python-setuptools \
        python-pip python-virtualenv ruby rake ruby-dev ctags \
        nano zsh 
fi

echo "cloning jcderr/dotfiles\n"
git clone --recursive https://github.com/jcderr/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/oh-my-zsh ~/.oh-my-zsh

if [ -x /usr/local/bin/brew ]; then
	brew install python3
	brew install pyenv

	pyenv install 3.9.0
	pyenv global 3.9.0
fi

echo "thanks for installing jcderr/dotfiles"
