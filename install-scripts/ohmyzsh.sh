#!/usr/bin/env bash

echo -e "${YELLOW}"
echo "--------------------------------"
echo "------- Oh My ZSH Setup --------"
echo "--------------------------------"
echo -e "${NOCOLOR}"

echo "Checking for oh-my-zsh"
if ! [[ -d "${OHMYZSH_DIR}" ]]; then
  echo 'Attempting to Install oh-my-zsh.' >&2
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  mkdir -pv "${OHMYZSH_THEME_DIR}"
fi

if ! [[ -d "${OHMYZSH_DIR}/custom/plugins/zsh-autosuggestions" ]]; then
  git clone "https://github.com/zsh-users/zsh-autosuggestions" "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if ! [[ -d "${OHMYZSH_DIR}/custom/plugins/zsh-syntax-highlighting" ]]; then
  git clone "https://github.com/zsh-users/zsh-syntax-highlighting" "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

echo "--------------------------------"
echo -e "${GREEN} oh-my-zsh installed ${NOCOLOR}"
echo "--------------------------------"
