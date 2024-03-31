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
# if [ -x "$(command -v lsb_release)" ]; then
if [ "$OS" = "Linux" ]; then
  LSBNAME=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
  OS_VER="$(grep -oP 'VERSION_ID="\K[\d.]+' /etc/os-release)"
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
SHELL_CONFIG_DIR=".shell_conf"
OHMYZSH_DIR="$HOME/.oh-my-zsh"
OHMYZSH_THEME_DIR="$OHMYZSH_DIR/custom/themes"
OHMYZSH_PLUGIN_DIR="$OHMYZSH_DIR/custom/plugins"
OHMYZSH_THEME=".oh-my-zsh/custom/themes/jimigrunge.zsh-theme"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;36m'
YELLOW='\033[1;33m'
NOCOLOR='\033[0m'
# ############################################################

echo -e "${BLUE}"
echo "--------------------------------"
echo "-- Begin installing dotfiles ---"
echo "--------------------------------"
echo ""
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
echo -e "${BLUE}"
# echo ""
echo "--------------------------------"
echo "-- Ensure needed  directories --"
echo "--------------------------------"
echo -e "${YELLOW}"
echo "${LOCAL_BIN}"
mkdir -pv "${LOCAL_BIN}"
echo "${CONFIG_HOME}"
mkdir -pv "${CONFIG_HOME}"
echo "${VIM_LOG}"
mkdir -pv "${VIM_LOG}"
echo "${COMPOSER_DIR}"
mkdir -pv "${COMPOSER_DIR}"
echo -e "${BLUE}"
echo "--------------------------------"
echo "-- Installing OS applications --"
echo "--------------------------------"
echo -e "${NOCOLOR}"
case "${OS}" in
  ${LINUX}*)
    if [ "${LSBNAME}" != '"Ubuntu"' ]; then
      echo -e "${RED}"
      echo "Linux distribution ${LSBNAME} not yet supported"
      echo -e "${NOCOLOR}"
      exit 1
    fi
    . ./install-scripts/ubuntu.sh
    . ./install-scripts/composer.sh
    ;;
  ${MAC}*)
    . ./install-scripts/macos.sh
    . ./install-scripts/composer.sh
    ;;
  *)
    echo -e "${RED}"
    echo "OS ${OS}:${LSBNAME}:${OS_VER} Is Not Supported"
    echo -e "${NOCOLOR}"
    exit 1
;; esac
echo -e "${GREEN}"
echo "OS install done"
echo -e "${NOCOLOR}"

echo -e "${BLUE}"
echo "--------------------------------"
echo "Begin linking configuration files"
echo "--------------------------------"
echo -e "${NOCOLOR}"

# -------------------------------
# Alacritty terminal
# -------------------------------
if [[ -d "${HOME}/${ALACRITTY_CONFIG}" ]]; then
  echo -e "${YELLOW}"
  echo "Backing up existing Alacritty config to ${HOME}/${ALACRITTY_CONFIG}.${TIMESTAMP}"
  echo -e "${NOCOLOR}"
  mv -f "${HOME}/${ALACRITTY_CONFIG}" "${HOME}/${ALACRITTY_CONFIG}.${TIMESTAMP}"
fi
echo -e "${YELLOW}"
echo "Creating symlink to Alacritty config"
echo -e "${NOCOLOR}"
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
echo -e "${YELLOW}"
echo "Creating symlink to NeoVim config"
echo -e "${NOCOLOR}"
ln -sf "${DOTFILEDIR}/${NVIM_CONFIG}" "${HOME}/${NVIM_CONFIG}"

# -------------------------------
# Shell config
# -------------------------------
if [[ -d "${HOME}/${SHELL_CONFIG_DIR}" ]]; then
  echo -e "${YELLOW}"
  echo "Backing up existing shell_configs to ${HOME}/${SHELL_CONFIG_DIR}.${TIMESTAMP}"
  echo -e "${NOCOLOR}"
  mv -f "${HOME}/${SHELL_CONFIG_DIR}" "${HOME}/${SHELL_CONFIG_DIR}.${TIMESTAMP}"
fi

echo -e "${YELLOW}"
echo "Installing shell_configs"
echo -e "${NOCOLOR}"

mkdir -p "${HOME}/${SHELL_CONFIG_DIR}"
cp "${DOTFILEDIR}/${SHELL_CONFIG_DIR}/.alias" "${HOME}/${SHELL_CONFIG_DIR}/.alias"
cp "${DOTFILEDIR}/${SHELL_CONFIG_DIR}/.paths" "${HOME}/${SHELL_CONFIG_DIR}/.paths"

if [[ -f "${HOME}/.bashrc" ]];then
  cp "${DOTFILEDIR}/.bashrc" "${HOME}/${SHELL_CONFIG_DIR}/.bashrc_local"
  echo "[ -f \"${HOME}/.shell_conf/.bashrc_local\" ] && source ${HOME}/.shell_conf/.bashrc_local" >> "${HOME}/.bashrc"
else
  cp "${DOTFILEDIR}/.bashrc" "${HOME}/.bashrc"
fi

# -------------------------------
# Symlink files/folders to ${HOME}
# -------------------------------
files=(".CodeSniffer.conf" ".gitconfig" ".tmux.conf" ".vimrc" ".zshrc")
for file in "${files[@]}"; do
  if [ -e "${HOME}/${file}" ]; then
    echo -e "${YELLOW}"
    echo "Backing up existing '${file}' to ${HOME}/${file}.${TIMESTAMP}"
    echo -e "${NOCOLOR}"
    mv "${HOME}/${file}" "${HOME}/${file}.${TIMESTAMP}"
  fi
  echo -e "${YELLOW}"
  echo "Copying ${file} to home directory."
  echo -e "${NOCOLOR}"
  cp "${DOTFILEDIR}/${file}" "${HOME}/${file}"
done

# -------------------------------
# NODE
# -------------------------------
echo -e "${BLUE}"
echo "--------------------------------"
echo "- Installing node configuration "
echo "--------------------------------"
echo -e "${NOCOLOR}"
. ./install-scripts/node.sh

echo -e "${BLUE}"
echo "--------------------------------"
echo "- Installing GetNF font control "
echo "--------------------------------"
if ! [ -x "$(command -v getnf)" ]; then
  curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
  echo -e "${GREEN}"
  echo "GetNF installed"
else
  echo -e "${GREEN}"
  echo "GetNF already installed"
fi
echo -e "${NOCOLOR}"

echo -e "${BLUE}"
echo "--------------------------------"
echo "-------- Setting up ZSH --------"
echo "--------------------------------"
echo -e "${NOCOLOR}"
. ./install-scripts/ohmyzsh.sh

echo -e "${BLUE}"
echo "----------------------------------"
echo "- Dotfile Installation Completed -"
echo "----------------------------------"
echo -e "${NOCOLOR}"
