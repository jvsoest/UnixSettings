# TODO:
#  - check https://github.com/neoclide/coc.nvim

printf "Select your OS:\n1 = Ubuntu (Debian)\n2 = MacOS\n\nFor MacOS, XCode needs to be installed beforehand\nChoice [1,2]: "
read osChoice

printf "Install pip and pydicom? [Y/n]"
read pythonChoice


if [ $osChoice == "1" ]; then
    #install git and curl (if needed)
    sudo apt-get install git curl vim python screen tmux
fi


if [ $osChoice == "2" ]; then
    printf "Install java and maven? [Y/n]"
    read javaMavenChoice
    
    xcode-select --install
    sudo xcodebuild -license
    
    #install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    #install homebrew on macOS
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install tmux pyenv pandoc git-lfs readline xz exiftool
    pyenv install 3.8.7
    pyenv global 3.8.7

    if [ $javaMavenChoice != "n" ]; then
        # Install OpenJDK 11
        brew install java11
        sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
        brew install maven
    fi
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

# Install time tracker
crontab -l > mycron
echo "* * * * * sh ~/Repositories/UnixSettings/track_time.sh" >> mycron
crontab mycron
rm mycron
