#add GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#add repository to apt-get
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#update the index of APT
sudo apt-get update

#install docker
sudo apt-get install -y docker-ce

#check running status
#sudo systemctl status docker

#add current user to the docker group
sudo usermod -aG docker ${USER}
