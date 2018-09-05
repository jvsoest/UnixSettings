#add GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#add repository to apt-get
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#update the index of APT
apt-get update

#install docker
apt-get install -y docker-ce docker-compose
