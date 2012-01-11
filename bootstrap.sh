#!/usr/bin/env sh

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

echo "thanks for installing jcderr/devenvironment, based on spf13-vim\n"

if [ -x /usr/bin/apt-get ]; then
    sudo apt-get -qq update
    sudo apt-get install -y git-core build-essential vim python-setuptools \
        python-pip python-virtualenv ruby rake rubygems ruby-dev ctags
fi

# Backup existing .vim stuff
echo "backing up current vim config\n"
for i in ~/.vim ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done


echo "cloning jcderr-devenvironment\n"
git clone --recursive https://bitbucket.org/jcderr/devenvironment.git ~/.devenv
ln -s ~/.devenv/.vimrc ~/.vimrc
ln -s ~/.devenv/.vim ~/.vim


# Build command-t for your system
echo "building command-t executable\n"
echo "command-t depends on ruby and rake to be present\n"
cd ~/.vim/bundle/command-t
(rake make) || warn "Ruby compilation failed. Ruby, GCC or rake not installed?"

# Optionally, create a python virtualenv with the first argument
if [ "$#" -ne 0 ]; then
    mkdir ~/.pyenv
    virtualenv ~/.pyenv/$1
fi
