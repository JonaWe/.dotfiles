curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

# temporary NVM configuration
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 12 --lts
nvm install 14 --lts
nvm install 16 --lts
nvm install 18 --lts
nvm install 20

nvm alias default lts/* 
