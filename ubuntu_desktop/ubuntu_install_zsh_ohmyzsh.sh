# git, wget, curl check
sudo apt-get install wget curl git -y

# Installing Zsh
sudo apt install zsh
# check zsh version
zsh --version

# Configure zsh (chose option 2 to new a "zshrc" file
chsh -s $(which zsh)

# Install Oh-my-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


