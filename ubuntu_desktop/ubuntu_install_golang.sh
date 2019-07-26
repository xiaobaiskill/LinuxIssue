
# install Go on ubuntu
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get -y upgrade

wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
sudo tar -xvf go1.12.6.linux-amd64.tar.gz

sudo mv go /usr/local

# Setup Go Env
# All the environment will be set for your current session only. To make it permanent add in ~/.profile file.
export GOPATH=/home/jimweng/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin



# Verify Installation
go version
go env



