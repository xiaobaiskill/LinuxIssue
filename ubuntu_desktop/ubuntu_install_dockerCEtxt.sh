# ubuntu install docker-ce
# Update the apt package index:
sudo apt-get update -y


# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common


# Add Docker¡¦s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
sudo apt-key fingerprint 0EBFCD88

# Add apt-repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# update apt package index again
sudo apt-get -y

# install the latest version of Docker CE and containerd
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

# use docker without "sudo"
# add another new group for docker
sudo groupadd docker

# privlage the user with docker cli
sudo gpasswd -a $USER docker