# TODO:
#  - check https://github.com/neoclide/coc.nvim

printf "Select your OS:\n1 = Ubuntu (Debian)\n2 = MacOS\n\nFor MacOS, XCode needs to be installed beforehand\nChoice [1,2]: "
read osChoice

printf "Install time tracker? [Y/n]"
read timeTrackerChoice

printf "Install java and maven? [Y/n]"
read javaMavenChoice

if [ $osChoice == "1" ]; then
    sudo apt update
    sudo apt upgrade -y

    #install git and curl (if needed)
    sudo apt install -y git curl vim screen tmux zsh python-is-python3 pandoc git-lfs exiftool libssl-dev liblzma-dev tk-dev

    #install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # install PyEnv
    sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    curl https://pyenv.run | bash

    # Install Azure CLI
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

    # Install Java and Maven
    if [ $javaMavenChoice == "Y" ]; then
      sudo add-apt-repository ppa:openjdk-r/ppa
      sudo apt-get update
      sudo apt install openjdk-11-jdk maven
    fi
fi

if [ $osChoice == "2" ]; then
    xcode-select --install
    sudo xcodebuild -license
    
    #install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    #install homebrew on macOS
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install tmux pyenv pandoc git-lfs readline xz exiftool
    pyenv install 3.8.7
    pyenv global 3.8.7
    
    # Set the correct python environment to work
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi

    # Install Azure-CLI (which is dependent on Python)
    brew install azure-cli

    if [ $javaMavenChoice == "Y" ]; then
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
# To update all plugins: vim +PluginUpdate +qall

mv ~/.zshrc ~/.zshrc_backup
ln -s ~/Repositories/UnixSettings/bash/.zshrc ~/.zshrc
ln -s ~/Repositories/UnixSettings/tmux.conf ~/.tmux.conf

#add scripts folder to path
chmod -R +x ~/Repositories/UnixSettings/scripts

#set vim as default editor for git commits
ln -s ~/Repositories/UnixSettings/.gitconfig ~/.gitconfig

# Install time tracker
if [ $timeTrackerChoice == "Y" ]; then
    crontab -l > mycron
    echo "* * * * * sh ~/Repositories/UnixSettings/track_time.sh" >> mycron
    crontab mycron
    rm mycron
fi

# Install Node Version Manager (nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
nvm install node
