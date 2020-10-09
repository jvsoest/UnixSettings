printf "Select your OS:\n1 = Ubuntu (Debian)\n2 = MacOS\nChoice [1,2]: "
read osChoice

printf "Install pip and pydicom? [Y/n]"
read pythonChoice

if [ $osChoice == "1" ]; then
    #install git and curl (if needed)
    sudo apt-get install git curl vim python screen tmux
fi


if [ $osChoice == "2" ]; then
    #install homebrew on macOS
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install tmux
fi

#install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#set .vimrc file to right location
ln -s ~/Repositories/UnixSettings/vim/.vimrc ~/.vimrc

#install plugins configured in .vimrc
vim +PluginInstall +qall

mv ~/.zshrc ~/.zshrc_backup
ln -s ~/Repositories/UnixSettings/bash/.zshrc ~/.zshrc
ln -s ~/Repositories/UnixSettings/tmux.conf ~/.tmux.conf

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

# install maven
mkdir -p ~/StandAlone/Apps
cd ~/StandAlone/Apps
curl -o apache-maven-3.6.3-bin.tar.gz https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

tar -xzvf apache-maven-3.6.3-bin.tar.gz
rm apache-maven-3.6.3-bin.tar.gz
