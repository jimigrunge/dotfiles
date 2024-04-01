#!/usr/bin/env bash

echo -e "${BLUE}"
echo "--------------------------------"
echo "--------- MacOS Setup ----------"
echo "--------------------------------"
echo -e "${NOCOLOR}"

# ----------------------------------------
# Install if not present otherwise Upgrade
# @param application name
# ----------------------------------------
function install_or_upgrade_brew {
  echo "Attempting to Install/Update ${1}."
  if brew ls --versions "${1}" >/dev/null; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "${1}"
  else
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "${1}"
  fi
}

echo -e "${BLUE}"
echo "--------------------------------"
echo "--- Checking for Xcode Tools ---"
echo "--------------------------------"
echo -e "${NOCOLOR}"
# ----------------------------------------
# Only run if the tools are not installed yet
# To check that try to print the SDK path
# ----------------------------------------
xcode-select -p &> /dev/null
if ! [ "$(xcode-select -p)" ]; then
  echo -e "${RED}"
  echo "Command Line Tools for Xcode not found."
  echo -e "${NOCOLOR}"
  echo "Installing from softwareupdate..."
  # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
  softwareupdate -i "${PROD}" -v;
else
  echo -e "${GREEN}"
  echo "Command Line Tools are installed."
  echo -e "${NOCOLOR}"
fi

echo -e "${BLUE}"
echo "--------------------------------"
echo "---- Checking for Homebrew -----"
echo "--------------------------------"
echo -e "${NOCOLOR}"
if ! [ -x "$(command -v brew)" ]; then
  echo -e "${RED}"
  echo 'MacOS requires homebrew package manager'
  echo -e "${NOCOLOR}"
  echo '  Attempting to install homebrew...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo -e "${GREEN}"
  echo "Homebrew found"
  echo -e "${NOCOLOR}"
fi

if [ -x "$(command -v brew)" ]; then
  brew update

  echo -e "${BLUE}"
  echo "--------------------------------"
  echo "- Installing command line tools-"
  echo "--------------------------------"
  echo -e "${NOCOLOR}"
  apps=(git node go lsd mcfly php jq nvim tmux composer phive bat tldr lazygit fd atuin "git-delta")
  for app in "${apps[@]}"; do
    install_or_upgrade_brew "${app}"
  done

  if ! [ -x "$(command -v pip)" ]; then
    install_or_upgrade_brew python
    pip install --upgrade pynvim
    pip3 install --upgrade pynvim
  fi

  if ! [ -x "$(command -v fzf)" ]; then
    install_or_upgrade_brew fzf
    "$(brew --prefix)"/opt/fzf/install
  fi

  if ! [ -x "$(command -v zsh)" ]; then
    install_or_upgrade_brew zsh
  fi

  if ! [ -x "$(command -v rg)" ]; then
    install_or_upgrade_brew ripgrep
  fi

  if ! [ -x "$(command -v rust-analyzer)" ]; then
    install_or_upgrade_brew rust
    install_or_upgrade_brew rust-analyzer
  fi
else
  echo -e "${RED}"
  echo "Homebrew not installed, command line tools not installed"
  echo -e "${NOCOLOR}"
fi

echo -e "$GREEN"
echo "--------------------------------"
echo "------ OS setup complete -------"
echo "--------------------------------"
echo -e "$NOCOLOR"
