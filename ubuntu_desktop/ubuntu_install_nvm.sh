# 1. Install NVM
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.profile
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.profile



# 2. Verify NVM Installation
source ~/.profile
nvm ls-remote


# 3. Install NodeJS (10.5.0)
nvm install 10.5.0


# 4. Verify NodeJS Installation
node -v


# # 5. Uninstall NodeJS(current)
# nvm unistall `nvm current`
