#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim zshrc zshenv oh-my-zsh private scrotwm.conf Xresources tmux.conf"    # list of files/folders to symlink in homedir
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'

##########

# create dotfiles_old in homedir
echo -en "${blue}Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo -e "${blue}Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/.$file ~/.$file
done

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/.oh-my-zsh/ ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git
        #mv $dir/oh-my-zsh $dir/.oh-my-zsh
        cd $dir/oh-my-zsh/plugins
        git clone https://github.com/rupa/z
        git clone https://github.com/zsh-users/zsh-syntax-highlighting
        cd ~/
    fi
    # Clone Vundle if not present
    if [[ ! -d $dir/.vim/plugged/ ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
              https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        vim +PlugInstall

        # Install Ruby and Make
        echo -e "${blue}Installing required packages"
        sudo apt-get install cmake cmake-qt-gui -y
        sudo apt-get install ruby -y
        sudo apt-get install ruby-dev -y

        echo -e "${blue}Trying to compile YouCompleteMe"

        echo "Trying to compile Command-T"
        cd $dir/.vim/bundle/command-t/ruby/command-t
        ruby extconf.rb
        make
        cd ~/
        echo -e "${green}Done! You will likely have to compile Command-T and YouCompleteMe if you want to use them"
        echo -e "${green} -> Also check if vim has +ruby, otherwise sudo apt-get install vim-nox"
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi

else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install zsh
        install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh
