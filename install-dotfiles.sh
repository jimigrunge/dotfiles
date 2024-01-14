#!/usr/bin/env bash
#
# JimiGrunge NeoVim configuration installer
#
# @author James Grundner <james@jgrundner.com>
#
# THIS IS A WORK IN PROGRESS - USE AT YOUR OWN RISK !!!
#
# ############################################################
# TODO: NerdFont install "DejaVuSansMono Nerd Font Book"
#       https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/DejaVuSansMono.zip
# TODO: Move Intelephense key file into place
# ############################################################

PWD=$(pwd)
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
CONST_LINUX="Linux"
CONST_MAC="Darwin"

NVIM_SRC_DIR=$PWD/config/nvim
ALACRITY_SRC_DIR=$PWD/config/alacritty
NVIM_INSTALL_DIR=$HOME/.config/nvim
ALACRITTY_CONFIG_DIR=$HOME/.config/alacritty
OHMYZSH_DIR="$HOME/.oh-my-zsh"
OHMYZSH_CONFIG_SRC="$PWD/.oh-my-zsh/custom/themes/jimigrunge.zsh-theme"
OHMYZSH_CONFIG_DEST=$HOME/.oh-my-zsh/custom/themes/jimigrunge.zsh-theme
LOCAL_BIN_DIR=$HOME/bin
VIM_LOG_DIR=$HOME/.log/vim
CONFIG_DIR=$HOME/.config
DBG_ADAPTER_DIR=$HOME/.local/share/debug-adapters
GLOBAL_NPM_DIR=$HOME/.npm
ZSH_VERSION=$(zsh --version)

# Get os type
unameOut="$(uname -s)"

echo "Installing NeoVim configuration..."
echo "OS: $unameOut"
echo "Installer dir: $NVIM_SRC_DIR"
echo "NeoVim install dir: $NVIM_INSTALL_DIR"
echo "Local bin dir: $LOCAL_BIN_DIR"


install_linux_deps()
{
    echo "OS setup begin"
    echo "Updating apt..."
    OS_VER="$(lsb_release -sr)"
    sudo apt-get update

    if ! [ -x "$(command -v git)" ]; then
        echo 'Error: git is not installed, attempting to install.' >&2
        sudo apt install git tig -y
    fi
    if ! [ -x "$(command -v pip)" ]; then
        echo 'Error: pip is not installed, attempting to install.' >&2
        sudo apt install python3-pip -y
        pip install --upgrade pynvim
    fi
    if ! [ -x "$(command -v node)" ]; then
        echo 'Error: nodejs is not installed, attempting to install.' >&2
        curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
        sudo apt install curl build-essential -y
        sudo apt-get install nodejs -y
    fi
    if ! [ -x "$(command -v go)" ]; then
        echo 'Error: go not found, attampting to install.' >&2
        sudo add-apt-repository ppa:longsleep/golang-backports
        sudo apt update
        sudo apt install golang-go
    fi
    if ! [ -x "$(command -v rg)" ]; then
        echo 'Error: ripgrep not found, attampting to install.' >&2
        sudo apt install ripgrep -y
    fi
    if ! [ -x "$(command -v xclip)" ]; then
        echo 'Error: xclip not found, attampting to install.' >&2
        sudo apt install xclip -y
    fi
    if ! [ -x "$(command -v fzf)" ]; then
        echo 'Error: fzf not found, attampting to install.' >&2
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install"
    fi
    if ! [ -x "$(command -v exa)" ]; then
        echo 'Error: exa not found, attampting to install.' >&2
        # Pre Ubuntu 20.04 exa needs to be compiled manually
        if (( $(echo "$OS_VER < 20.10" | bc -l) )); then
          EXA_TAG=$(curl -I https://github.com/ogham/exa/releases/latest | awk -F '/' '/^location/ {print  substr($NF, 1, length($NF)-1)}' )
          curl -Lo exa.zip "https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-${EXA_TAG}.zip"
          unzip -q exa.zip bin/exa -d "${HOME}"
          rm -rf exa.zip
        else
          sudo apt install exa
        fi
    fi
    if ! [ -x "$(command -v lsd)" ]; then
        echo 'Error: lsd not found, attampting to install.' >&2
        # Pre Ubuntu 23.04 exa needs to be compiled manually
        if (( $(echo "$OS_VER < 23.04" | bc -l) )); then
          echo "ERROR: lsd requires Ubuntu >= 23.04, you have version $OS_VER." >&2
          echo '  skipping lsd install.'
        else
          sudo apt install lsd
        fi
    fi
    if ! [[ -d "$OHMYZSH_DIR" ]]; then
        echo 'Error: oh-my-zsh not found, attampting to install.' >&2
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    if ! [[ -d "$OHMYZSH_DIR/custom/plugins/zsh-autosuggestions" ]]; then
        git clone "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    fi
    if ! [[ -d "$OHMYZSH_DIR/custom/plugins/zsh-syntax-highlighting" ]]; then
        git clone "https://github.com/zsh-users/zsh-syntax-highlighting" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    fi
    if ! [ -x "$(command -v mcfly)" ]; then
        echo 'Error: mcfly not found, attampting to install.' >&2
        curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly --to "${LOCAL_BIN_DIR}"
    fi
    if ! [ -x "$(command -v php)" ]; then
        echo 'Error: php not found, attampting to install.' >&2
        sudo apt install -y php php-cli php-fpm php-json php-common php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath
    fi
    if ! [ -x "$(command -v composer)" ]; then
        echo 'Error: composer not found, attampting to install.' >&2
        install_composer
    fi
    if ! [ -x "$(command -v cargo)" ]; then
        # Pre Ubuntu 20.04 cargo needs to be installed manually
        if (( $(echo "$OS_VER < 20.04" | bc -l) )); then
          curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        else
          sudo apt install -y rustc
        fi
    fi
    if ! [ -x "$(command -v jq)" ]; then
        echo 'Error: jq not found, attampting to install.' >&2
        sudo apt install jq -y
    fi
    if ! [ -x "$(command -v nvim)" ]; then
        echo 'Error: NeoVim not found, attampting to install.' >&2
        sudo apt install neovim -y
        sudo apt install python3-neovim -y
    fi
    if ! [ -x "$(command -v tmux)" ]; then
        echo 'Error: Tmux not found, attampting to install.' >&2
        sudo apt-get install tmux -y
    fi

    echo "OS setup complete"
}

install_mac_deps()
{
    echo "OS setup begin"

    if ! [ -x "$(command -v brew)" ]; then
        echo 'Error: MacOS requires homebrew package manager' >&2
        echo '  Attempting to install homebrew...' >&2
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    if [ -x "$(command -v brew)" ]; then
      echo 'Updating Homebrew.' >&2
      brew update
    fi
    if ! [ -x "$(command -v git)" ]; then
        echo 'Error: git is not installed, attempting to install.' >&2
        brew install git
    fi
    if ! [ -x "$(command -v pip)" ]; then
        echo 'Error: pip is not installed, attempting to install.' >&2
        brew install python
        pip install --upgrade pynvim
        pip3 install --upgrade pynvim
    fi
    if ! [ -x "$(command -v node)" ]; then
        echo 'Error: nodejs is not installed, attempting to install.' >&2
        brew install node
    fi
    if ! [ -x "$(command -v go)" ]; then
        echo 'Error: go is not installed, attempting to install.' >&2
        brew install go
    fi
    if ! [ -x "$(command -v rg)" ]; then
        echo 'Error: ripgrep is not installed, attempting to install.' >&2
        brew install ripgrep
    fi
    if ! [ -x "$(command -v fzf)" ]; then
        echo 'Error: fzf not found, attampting to install.' >&2
        brew install fzf
        "$(brew --prefix)"/opt/fzf/install
    fi
    if ! [ -x "$(command -v lsd)" ]; then
        echo 'Error: lsd not found, attampting to install.' >&2
        brew install lsd
    fi
    if ! [[ -d "$OHMYZSH_DIR" ]]; then
        echo 'Error: oh-my-zsh not found, attampting to install.' >&2
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    if ! [[ -d "$OHMYZSH_DIR/custom/plugins/zsh-autosuggestions" ]]; then
        git clone "https://github.com/zsh-users/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    fi
    if ! [[ -d "$OHMYZSH_DIR/custom/plugins/zsh-syntax-highlighting" ]]; then
        git clone "https://github.com/zsh-users/zsh-syntax-highlighting" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    fi
    if ! [ -x "$(command -v mcfly)" ]; then
        echo 'Error: mcfly not found, attampting to install.' >&2
        brew install mcfly
    fi
    if ! [ -x "$(command -v rust-analyzer)" ]; then
        echo 'Error: rust not found, attampting to install.' >&2
        brew install rust
        brew install rust-analyzer
    fi
    if ! [ -x "$(command -v php)" ]; then
        echo 'Error: php not found, attampting to install.' >&2
        brew install php
    fi
    if ! [ -x "$(command -v composer)" ]; then
        echo 'Error: composer not found, attampting to install.' >&2
        install_composer
    fi
    if ! [ -x "$(command -v jq)" ]; then
        echo 'Error: jq not found, attampting to install.' >&2
        brew install jq
    fi
    if ! [ -x "$(command -v nvim)" ]; then
        echo 'Error: NeoVim not found, attampting to install.' >&2
        brew install neovim
    fi
    if ! [ -x "$(command -v tmux)" ]; then
        echo 'Error: Tmux not found, attampting to install.' >&2
        brew install tmux
    fi

    echo "OS setup complete"
}

create_dirs()
{
    echo "Making sure required directories exist"
    # Create log directory if not present
    mkdir -pv "$VIM_LOG_DIR"
    # Create local bin
    mkdir -pv "$LOCAL_BIN_DIR"
    # Create step debug config directory
    mkdir -pv "$CONFIG_DIR"
    # Create debug adapter directory
    mkdir -pv "$DBG_ADAPTER_DIR"
    # Create alacritty config directory
    mkdir -pv "$ALACRITTY_CONFIG_DIR"
}

# Fix for npm's global permissions issue
fix_npm_global_perms()
{
    echo "Fixing NPM permissions"
    mkdir -pv "$GLOBAL_NPM_DIR"
    npm config set prefix "$GLOBAL_NPM_DIR"
    export PATH=$GLOBAL_NPM_DIR/bin:$PATH
}

# Language server installs
install_libraries()
{
    echo "Installing Libraries"

    echo "Ensuring we have NPM dependancies"
    echo "* Checking for n npm version manager"
    if ! [ -x "$(command -v n)" ]; then
        npm install -g n
    fi
    echo "* Checking for neovim bridge"
    if ! [ -x "$(command -v neovim-node-host)" ]; then
        npm install -g neovim
    fi
    echo "* Checking for typescript"
    if ! [ -x "$(command -v tsc)" ]; then
        npm install -g typescript
    fi
    # TODO: are these needed anymore now that we have MASON?
    # echo "* Checking for prettier"
    # if ! [ -x "$(command -v prettier)" ]; then
    #     npm install -g prettier
    # fi
    # echo "* Checking for eslint"
    # if ! [ -x "$(command -v eslint)" ]; then
    #     npm install -g eslint
    # fi
    # echo "* Checking for eslint-d"
    # if ! [ -x "$(command -v eslint_d)" ]; then
    #     npm install -g eslint_d
    # fi

    echo "Insure we have PHP Linting and Formatting"
    echo "* Checking for php code sniffer"
    if ! [ -e "$LOCAL_BIN_DIR"/phpcs ]; then
        wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
        mv phpcs.phar "$LOCAL_BIN_DIR"/phpcs

        wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
        mv phpcbf.phar "$LOCAL_BIN_DIR"/phpcbf
    fi

    echo "* Checking for php-cs-fixer"
    if ! [ -e "$LOCAL_BIN_DIR"/php-cs-fixer ]; then
        wget https://cs.symfony.com/download/php-cs-fixer-v3.phar -O php-cs-fixer
        mv php-cs-fixer "$LOCAL_BIN_DIR"/php-cs-fixer
    fi

    echo "* Checking for php mess detector"
    if ! [ -e "$LOCAL_BIN_DIR"/phpmd ]; then
        wget -c https://phpmd.org/static/latest/phpmd.phar
        mv phpmd.phar "$LOCAL_BIN_DIR"/phpmd
    fi

    echo "Library installs complete"
}

install_nvim_files()
{
    echo "Backing up current NeoVim configurations to $NVIM_INSTALL_DIR.$TIMESTAMP"
    if [[ -d "$NVIM_INSTALL_DIR" ]]; then
        mv -f "$NVIM_INSTALL_DIR" "$NVIM_INSTALL_DIR.$TIMESTAMP"
    fi

    echo "Copying nvim configuration into place"
    cp -r "$NVIM_SRC_DIR" "$NVIM_INSTALL_DIR"
}

install_composer()
{
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php --install-dir="$LOCAL_BIN_DIR" --filename=composer
    php -r "unlink('composer-setup.php');"

    export PATH=$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:$PATH
    echo "Composer install complete"
}

symlink()
{
    if [ -e "$HOME"/"$1" ]; then
      echo "Found existing file, created backup: $HOME/${1}.bak"
      mv "$HOME/$1" "$HOME/$1.bak"
    fi
    ln -sf "$PWD/$1" "$HOME/$1";
}

install_shell_configs()
{
    if [[ -d "$ALACRITTY_CONFIG_DIR" ]]; then
        mv -f "$ALACRITTY_CONFIG_DIR" "$ALACRITTY_CONFIG_DIR.$TIMESTAMP"
    fi
    cp -r "$ALACRITY_SRC_DIR" "$ALACRITTY_CONFIG_DIR"

    cp "$OHMYZSH_CONFIG_SRC" "$OHMYZSH_CONFIG_DEST"

    symlink .alias
    symlink .CodeSniffer.conf
    symlink .gitconfig
    symlink .tmux.conf
    symlink .zshrc
}

intitialize_zsh()
{
   echo "Changing shell to ZSH"
    SHELL=$(which zsh)
    [ -z "$ZSH_VERSION" ] && exec "$SHELL" -l

    echo "Zsh version: $ZSH_VERSION"
    if [[ -f $HOME/.zshrc ]]; then
        echo "Sourcing zsh profile"
        source "$HOME/.zshrc"
    fi
}

# Begin installation process
case "$unameOut" in
    ${CONST_LINUX}*)
        echo "$CONST_LINUX"
        install_linux_deps
        ;;
    ${CONST_MAC}*)
        echo "$CONST_MAC"
        install_mac_deps
        ;;
    *)          MACHINE="UNKNOWN:${unameOut}"
        echo "OS ${MACHINE} Is Not Supported"
        exit 1
;; esac

create_dirs
install_shell_configs
fix_npm_global_perms
install_libraries
install_nvim_files
intitialize_zsh

echo "Development Environment Install Complete"
exit 0
