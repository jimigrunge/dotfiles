#!/usr/bin/env bash

echo -e "$BLUE"
echo "--------------------------------"
echo "-------- Ubuntu Setup ----------"
echo "--------------------------------"
echo -e "$NOCOLOR"

echo "Updating apt-get"
sudo apt-get update

function install_app {
  if ! [ -x "$(command -v "${1}")" ]; then
    echo "Attempting to Install ${1}."
    sudo apt install "${1}" -y
  fi
}

apps=("software-properties-common" "curl" "git" "wget" "bc" "zsh" "xclip" "jq" "tmux" "zip" "unzip" "perl" "tldr" "lazygit")
for app in "${apps[@]}"; do
  install_app "$app"
done

if ! [ -x "$(command -v nvim)" ]; then
  echo "Attempting to Install neovim."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  tar -xzf nvim-linux64.tar.gz
  cd nvim-linux64
  sudo cp bin/nvim /usr/local/bin/nvim
  sudo cp -r lib/nvim /usr/local/lib/nvim
  sudo mkdir -pv /usr/local/man/man1
  sudo cp man/man1/nvim.1 /usr/local/man/man1/nvim.1
  sudo cp -r share /usr/local/
  cd "${DOTFILEDIR}"
  rm -r nvim-linux64
  rm nvim-linux64.tar.gz

  install_app python3-neovim
fi

if ! [ -x "$(command -v gcc)" ]; then
  install_app build-essential
fi

if ! [ -x "$(command -v pip)" ]; then
  install_app python3-pip
  pip install --upgrade pynvim
  pip3 install --upgrade pynvim
fi

if ! [ -x "$(command -v node)" ]; then
  install_app nodejs
  install_app npm
fi

if ! [ -x "$(command -v go)" ]; then
  sudo add-apt-repository ppa:longsleep/golang-backports
  sudo apt update
  install_app golang-go
fi

if ! [ -x "$(command -v rg)" ]; then
  install_app ripgrep
fi

if ! [ -x "$(command -v fzf)" ]; then
  echo 'Attempting to Install fzf.'
  git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
  "$HOME/.fzf/install"
fi
if ! [ -x "$(command -v mcfly)" ]; then
  echo 'Attempting to Install mcfly.'
  curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly --to "$LOCAL_BIN"
fi

if ! [ -x "$(command -v php)" ]; then
  install_app php
  install_app php-cli
  install_app php-fpm
  install_app php-json
  install_app php-common
  install_app php-mysql
  install_app php-zip
  install_app php-gd
  install_app php-mbstring
  install_app php-curl
  install_app php-xml
  install_app php-pear
  install_app php-bcmath
fi

if ! [ -x "$(command -v cargo)" ]; then
  # Pre Ubuntu 20.04 cargo needs to be installed manually
  if (( $(echo "${OS_VER} < 20.04" | bc -l) )); then
    echo 'Attempting to Install rust.'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  else
    install_app cargo
  fi
fi

if ! [ -x "$(command -v bat)" ]; then
  # Pre Ubuntu 20.04 bat needs to be installed manually
  if (( $(echo "${OS_VER} < 20.04" | bc -l) )); then
    echo 'Attempting to Install bat.'
    curl -LO https://github.com/sharkdp/bat/releases/download/v0.18.3/bat_0.18.3_amd64.deb
    sudo dpkg -i bat_0.18.3_amd64.deb
    rm -f bat_0.18.3_amd64.deb
  else
    if ! [ -x "$(command -v batcat)" ]; then
      install_app bat
    fi
    ln -s /usr/bin/batcat "${LOCAL_BIN}/bat"
  fi
fi

if ! [ -x "$(command -v lsd)" ]; then
  # Pre Ubuntu 23.04 lsd needs to be compiled manually
  if (( $(echo "${OS_VER} < 23.04" | bc -l) )); then
    echo 'Attempting to Install lsd.' >&2
    echo -e "$RED"
    echo "ERROR: 'apt-get lsd' requires Ubuntu >= 23.04, you have version ${OS_VER}." >&2
    echo -e "$NOCOLOR"
    echo '  attempting to install with cargo.'
    cargo install lsd
  else
    install_app lsd
  fi
fi

if ! [ -x "$(command -v phive)" ]; then
  echo 'Attempting to Install Phive.'
  wget -O phive.phar "https://phar.io/releases/phive.phar"
  chmod +x phive.phar
  mv phive.phar "${LOCAL_BIN}/phive"
fi

if ! [ -x "$(command -v lazygit)" ]; then
  echo 'Attempting to Install lazygit.'
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
fi

if ! [ -x "$(command -v fdfind)" ]; then
  # Pre Ubuntu 20.04 fd-find needs to be installed manually
  if (( $(echo "${OS_VER} < 20.04" | bc -l) )); then
    echo 'Attempting to Install fd-find.'
    curl -LO https://github.com/sharkdp/fd/releases/download/v9.0.0/fd_9.0.0_amd64.deb
    sudo dpkg -i fd_9.0.0_amd64.deb
    rm -f fd_9.0.0_amd64.deb
  else
    install_app fd-find
    ln -s $(which fdfind) "${LOCAL_BIN}/fd"
  fi
fi

if ! [ -x "$(command -v atuin)" ]; then
  cargo install atuin
fi

if ! [ -x "$(command -v delta)" ]; then
  cargo install git-delta
fi

echo -e "$GREEN"
echo "--------------------------------"
echo "------ OS setup complete -------"
echo "--------------------------------"
echo -e "$NOCOLOR"
