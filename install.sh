printf "Select your OS:\n1 = Ubuntu (Debian)\n2 = MacOS\nChoice [1,2]: "
read osChoice

if [ $osChoice == "1" ]; then
    #install git and curl (if needed)
    sudo apt-get install git curl vim python screen tmux
fi


if [ $osChoice == "2" ]; then
    #install homebrew on macOS
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install tmux
fi

printf "Install pip and pydicom? [Y/n]"
read pythonChoice

#install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#add git integration on command line
curl -LSso ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -LSso ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

#install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#set .vimrc file to right location
ln -s ~/Repositories/UnixSettings/vim/.vimrc ~/.vimrc

#install plugins configured in .vimrc
vim +PluginInstall +qall

#set bash settings (git integration)
if [ $osChoice == "1" ]; then
    ln -s ~/Repositories/UnixSettings/bash/.bashrc_ubuntu ~/.bashrc
fi
if [ $osChoice == "2" ]; then
    ln -s ~/Repositories/UnixSettings/bash/.bashrc ~/.bashrc
fi
ln -s ~/Repositories/UnixSettings/bash/.screenrc ~/.screenrc
ln -s ~/Repositories/UnixSettings/tmux.conf ~/.tmux.conf
ln -s ~/Repositories/UnixSettings/bash/.bash_profile ~/.bash_profile

#add scripts folder to path
chmod -R +x ~/Repositories/UnixSettings/scripts

#set vim as default editor for git commits
ln -s ~/Repositories/UnixSettings/.gitconfig ~/.gitconfig

if [ $pythonChoice != "n" ]; then
    #install python and libs
    curl -o get-pip.py https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    sudo pip install pydicom
fi

