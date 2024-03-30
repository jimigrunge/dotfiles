#!/usr/bin/env bash
# ############################################################
#
# JimiGrunge NeoVim configuration installer
#
# @author James Grundner <james@jgrundner.com>
#
# THIS IS A WORK IN PROGRESS - USE AT YOUR OWN RISK !!!
#
# ############################################################

# ############################################################
# Configure CONSTANTS
# ############################################################
#
# Install tilestamp for creating backups
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
# Dotfile directory
DOTFILEDIR="${HOME}/.dotfiles"
# which OS
LINUX="Linux"
MAC="Darwin"
OS="$(uname -s)"
if [ -x "$(command -v lsb_release)" ]; then
  LSBNAME=$(lsb_release -i)
  OS_VER="$(lsb_release -sr)"
else
  LSBNAME="Unknown"
  OS_VER="Unknown"
fi
# define directories
LOCAL_BIN=$HOME/bin
CONFIG_HOME=$HOME/.config
COMPOSER_DIR="$HOME/.composer"
VIM_LOG=$HOME/.log/vim
NPM_DIR=$HOME/.npm
ALACRITTY_CONFIG=".config/alacritty"
NVIM_CONFIG=".config/nvim"
OHMYZSH_DIR="$HOME/.oh-my-zsh"
OHMYZSH_THEME=".oh-my-zsh/custom/themes/jimigrunge.zsh-theme"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;36m'
YELLOW='\033[1;33m'
NOCOLOR='\033[0m'
# ############################################################

echo -e "${BLUE}"
echo "Begin installing dotfiles"
echo -e "${NOCOLOR}"
echo "--------------------------------"
echo "---- System Configurations  ----"
echo "--------------------------------"
echo -e "${YELLOW}"
echo "OS: ${OS}"
echo "Local 'bin' dir: ${LOCAL_BIN}"
echo "Alacrity config dir: ${HOME}/${ALACRITTY_CONFIG}"
echo "NeoVim config dir: ${HOME}/${NVIM_CONFIG}"
echo "Zsh theme: ${HOME}/${OHMYZSH_THEME}"
echo -e "${NOCOLOR}"
echo "--------------------------------"
echo ""
echo "--------------------------------"
echo "-- Ensure needed  directories --"
echo "--------------------------------"
echo ""
echo "${LOCAL_BIN}"
mkdir -pv "${LOCAL_BIN}"
echo "${CONFIG_HOME}"
mkdir -pv "${CONFIG_HOME}"
echo "${VIM_LOG}"
mkdir -pv "${VIM_LOG}"
echo "${COMPOSER_DIR}"
mkdir -pv "${COMPOSER_DIR}"

echo ""
echo "--------------------------------"
echo "-- Installing OS applications --"
echo "--------------------------------"
echo ""
case "${OS}" in
  ${LINUX}*)
    if [ "${LSBNAME}" != "Ubuntu" ]; then
      echo -e "${RED}"
      echo "Linux distribution ${LSBNAME} not yet supported"
      echo -e "${NOCOLOR}"
      exit 1
    fi

    echo "Instaling applications for ${LSBNAME}"
    . ./install-scripts/ohmyzsh.sh
    . ./install-scripts/ubuntu.sh
    . ./install-scripts/composer.sh
    ;;
  ${MAC}*)
    echo "Instaling applications for macOS"
    . ./install-scripts/ohmyzsh.sh
    . ./install-scripts/macos.sh
    . ./install-scripts/composer.sh
    ;;
  *)
    echo -e "${RED}"
    echo "OS ${OS}:${LSBNAME}:${OS_VER} Is Not Supported"
    echo -e "${NOCOLOR}"
    exit 1
;; esac
echo ""
echo "--------------------------------"
echo "Begin linking configuration files"
echo "--------------------------------"
echo ""

# -------------------------------
# Alacritty terminal
# -------------------------------
if [[ -d "${HOME}/${ALACRITTY_CONFIG}" ]]; then
  echo -e "${YELLOW}"
  echo "Backing up existing Alacritty config to ${HOME}/${ALACRITTY_CONFIG}.${TIMESTAMP}"
  echo -e "${NOCOLOR}"
  mv -f "${HOME}/${ALACRITTY_CONFIG}" "${HOME}/${ALACRITTY_CONFIG}.${TIMESTAMP}"
fi
echo "Creating symlink to Alacritty config"
ln -sf "${DOTFILEDIR}/${ALACRITTY_CONFIG}" "${HOME}/${ALACRITTY_CONFIG}"

# -------------------------------
# NeoVim theme
# -------------------------------
if [[ -d "${HOME}/${NVIM_CONFIG}" ]]; then
  echo -e "${YELLOW}"
  echo "Backing up existing NeoVim to ${HOME}/${NVIM_CONFIG}.${TIMESTAMP}"
  echo -e "${NOCOLOR}"
  mv -f "${HOME}/${NVIM_CONFIG}" "${HOME}/${NVIM_CONFIG}.${TIMESTAMP}"
fi
echo "Creating symlink to NeoVim config"
ln -sf "${DOTFILEDIR}/${NVIM_CONFIG}" "${HOME}/${NVIM_CONFIG}"

# -------------------------------
# ZSH theme
# -------------------------------
if [ -e "${HOME}/${OHMYZSH_THEME}" ]; then
  echo -e "${YELLOW}"
  echo "Backing up existing OhMyZsh theme to ${HOME}/${OHMYZSH_THEME}.${TIMESTAMP}"
  echo -e "${NOCOLOR}"
  mv "${HOME}/${OHMYZSH_THEME}" "${HOME}/${OHMYZSH_THEME}.${TIMESTAMP}"
fi
echo "Creating symlink to ZSH theme"
ln -sf "${DOTFILEDIR}/${OHMYZSH_THEME}" "${HOME}/${OHMYZSH_THEME}"

# -------------------------------
# Symlink files/folders to ${HOME}
# -------------------------------
files=(".alias" ".CodeSniffer.conf" ".gitconfig" ".tmux.conf" ".vimrc" ".zshrc")
for file in "${files[@]}"; do
  if [ -e "${HOME}/${file}" ]; then
    echo -e "${YELLOW}"
    echo "Backing up existing '${file}' to ${HOME}/${file}.${TIMESTAMP}"
    echo -e "${NOCOLOR}"
    mv "${HOME}/${file}" "${HOME}/${file}.${TIMESTAMP}"
  fi
  echo "Copying ${file} to home directory."
  cp "${DOTFILEDIR}/${file}" "${HOME}/${file}"
done

# -------------------------------
# Node specific configurations
# -------------------------------
. ./install-scripts/node.sh

echo "--------------------------------"
echo "- Installing GetNF font control "
echo "--------------------------------"
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash

echo "--------------------------------"
echo "- Insure ZSH is default shell --"
echo "--------------------------------"
if [ "${SHELL}" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
  if [ "${SHELL}" != "$(which zsh)" ]; then
    # reverting back to the previous shell if there are any issues during the process
    echo -e "${RED}"
    echo "Error: issue switching default shell to ZSH"
    echo -e "${NOCOLOR}"
    exec "$SHELL" -l
  fi
fi
if [ "${SHELL}" = "$(which zsh)" ]; then
  # source the ZSH configuration
  echo "Zsh version: $(zsh --version)"
  if [[ -f ${HOME}/.zshrc ]]; then
    echo "Sourcing zsh profile"
    source "${HOME}/.zshrc"
  fi
fi

echo ""
echo "--------------------------------"
echo "---- Installation Completed ----"
echo "--------------------------------"
