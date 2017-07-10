#install git and curl (if needed)
sudo apt-get install git curl vim python python-pip

#install homebrew on macOS
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#add git integration on command line
curl -LSso ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -LSso ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

#install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#set .vimrc file to right location
cp ~/Repositories/UnixSettings/vim/.vimrc ~/.vimrc

#install plugins configured in .vimrc
vim +PluginInstall +qall

#set bash settings (git integration)
cp ~/Repositories/UnixSettings/bash/.bashrc_ubuntu ~/.bashrc
cp ~/Repositories/UnixSettings/bash/.bash_profile ~/.bash_profile

#add scripts folder to path
chmod -R +x ~/Repositories/UnixSettings/scripts

#set vim as default editor for git commits
git config --global core.editor "vim"

#install python and libs
#brew install python
sudo pip install pydicom
