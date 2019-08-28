#!/bin/bash

set -e

echo "apt-get updating and installing all the things"
sudo apt --fix-broken -y install
sudo apt-get -y install curl # wget netselect # need to fix netselect

# --- apt-fast
if command -v apt-fast; then
    echo already have apt-fast
else
    echo installing apt-fast
    /bin/bash -c "$(curl -sL https://git.io/vokNn)"
fi

sudo apt-get autoremove
sudo apt-get -y upgrade       # Strictly upgrades the current packages

# --- Misc Libraries
sudo apt-fast -y install linux-headers-`uname -r`
sudo apt-fast -y install \
     git vim zsh curl tmux mosh clang-6.0 clang-tidy-6.0 \
     build-essential zip unzip wget cmake libc++-dev clang-6.0-doc \
     libclang-common-6.0-dev libclang-6.0-dev htop atop extundelete \
     openssh-server openjdk-8-jdk libtool clang-format-6.0 m4 automake \
     python3.7 python3.7-dev libpython3.7-dev jq httpie kubectl \
     protobuf-compiler-grpc docker.io finger python-pip ansible libssl-dev \
     build-essential cmake flex git libedit-dev \
     libllvm6.0 llvm-6.0-dev libclang-6.0-dev python zlib1g-dev libelf-dev \
     clang-format golang-go go-dep cargo ripgrep ack-grep aria2

# --- Google Cloud SDK

# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk

# --- Google Chrome

aria2c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -d ~/Downloads
sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
rm ~/Downloads/google-chrome-stable_current_amd64.deb

# --- Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# --- vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

