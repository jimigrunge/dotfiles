#!/usr/bin/env bash

echo -e "${YELLOW}"
echo "--------------------------------"
echo "-------- Ubuntu Setup ----------"
echo "--------------------------------"
echo -e "${NOCOLOR}"

echo "Updating apt-get"
sudo apt-get update

if ! [ -x "$(command -v git)" ]; then
  echo 'Attempting to Install git.'
  sudo apt install git tig -y
fi
if ! [ -x "$(command -v zsh)" ]; then
  echo 'Attempting to Install zsh.'
  sudo apt install zsh -y
fi
if ! [ -x "$(command -v pip)" ]; then
  echo 'Attempting to Install pip.'
  sudo apt install python3-pip -y
  pip install --upgrade pynvim
  pip3 install --upgrade pynvim
fi
if ! [ -x "$(command -v node)" ]; then
  echo 'Attempting to Install nodejs.'
  curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
  sudo apt install curl build-essential -y
  sudo apt-get install nodejs -y
fi
if ! [ -x "$(command -v go)" ]; then
  echo 'Attempting to Install go.'
  sudo add-apt-repository ppa:longsleep/golang-backports
  sudo apt update
  sudo apt install golang-go
fi
if ! [ -x "$(command -v rg)" ]; then
  echo 'Attempting to Install ripgrep.'
  sudo apt install ripgrep -y
fi
if ! [ -x "$(command -v xclip)" ]; then
  echo 'Attempting to Install xclip.'
  sudo apt install xclip -y
fi
if ! [ -x "$(command -v fzf)" ]; then
  echo 'Attempting to Install fzf.'
  git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
  "$HOME/.fzf/install"
fi
if ! [ -x "$(command -v mcfly)" ]; then
  echo 'Attempting to Install mcfly.'
  curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly --to "${LOCAL_BIN}"
fi
if ! [ -x "$(command -v php)" ]; then
  echo 'Attempting to Install php.'
  sudo apt install -y php php-cli php-fpm php-json php-common php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath
fi
if ! [ -x "$(command -v cargo)" ]; then
  echo 'Attempting to Install rust.'
  # Pre Ubuntu 20.04 cargo needs to be installed manually
  if (( $(echo "${OS_VER} < 20.04" | bc -l) )); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  else
    sudo apt install -y rustc
  fi
fi
if ! [ -x "$(command -v exa)" ]; then
  echo 'Attempting to Install exa.' >&2
  # Pre Ubuntu 20.10 exa needs to be compiled manually
  if (( $(echo "${OS_VER} < 20.10" | bc -l) )); then
    echo -e "${RED}"
    echo "ERROR: 'apt-get exa' requires Ubuntu >= 20.10, you have version ${OS_VER}." >&2
    echo -e "${NOCOLOR}"
    echo '  attempting to install with cargo.'
    cargo install exa
  else
    sudo apt install exa
  fi
fi
if ! [ -x "$(command -v lsd)" ]; then
  echo 'Attempting to Install lsd.' >&2
  # Pre Ubuntu 23.04 lsd needs to be compiled manually
  if (( $(echo "${OS_VER} < 23.04" | bc -l) )); then
    echo -e "${RED}"
    echo "ERROR: 'apt-get lsd' requires Ubuntu >= 23.04, you have version ${OS_VER}." >&2
    echo -e "${NOCOLOR}"
    echo '  attempting to install with cargo.'
    cargo install lsd
  else
    sudo apt install lsd
  fi
fi
if ! [ -x "$(command -v jq)" ]; then
  echo 'Attempting to Install jq.'
  sudo apt install jq -y
fi
if ! [ -x "$(command -v nvim)" ]; then
  echo 'Attempting to Install NeoVim.'
  sudo apt install neovim -y
  sudo apt install python3-neovim -y
fi
if ! [ -x "$(command -v tmux)" ]; then
  echo 'Attempting to Install Tmux.'
  sudo apt-get install tmux -y
fi
if ! [ -x "$(command -v phive)" ]; then
  echo 'Attempting to Install Phive.'
  wget -O phive.phar "https://phar.io/releases/phive.phar"
  chmod +x phive.phar
  mv phive.phar "${LOCAL_BIN}/phive"
fi

echo "--------------------------------"
echo -e "${GREEN} OS setup complete ${NOCOLOR}"
echo "--------------------------------"
