#!/usr/bin/env sh

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

echo "thanks for installing jcderr/dotfiles"

if [ -x /usr/bin/apt-get ]; then
    sudo apt-get -qq update
    sudo apt-get install -y git-core build-essential vim python-setuptools \
        python-pip python-virtualenv ruby rake ruby-dev ctags \
        nano zsh 
fi

sudo pip install reattach-to-user-namespace

# Backup existing .vim stuff
echo "backing up current vim config\n"
for i in ~/.vim ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done


echo "cloning jcderr/workspace\n"
git clone --recursive https://github.com/jcderr/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/oh-my-zsh ~/.oh-my-zsh
cd ~/.dotfiles/powerline-fonts && python ./install.py
