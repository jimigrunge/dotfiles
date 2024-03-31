#!/usr/bin/env bash

echo -e "${BLUE}"
echo "--------------------------------"
echo "------- Oh My ZSH Setup --------"
echo "--------------------------------"
echo -e "${NOCOLOR}"

# -------------------------------
# Oh my zsh
# -------------------------------
echo "Checking for oh-my-zsh"
if ! [[ -f "${OHMYZSH_DIR}/oh-my-zsh.sh" ]]; then
  echo -e "${YELLOW}"
  echo "Oh My ZSH not found"
  echo "Attempting to Install oh-my-zsh."
  echo -e "${NOCOLOR}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
  mkdir -pv "${OHMYZSH_THEME_DIR}"
fi

if ! [[ -d "${OHMYZSH_DIR}/custom/plugins/zsh-autosuggestions" ]]; then
  echo "installing missing auto suggestions"
  git clone "https://github.com/zsh-users/zsh-autosuggestions" "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if ! [[ -d "${OHMYZSH_DIR}/custom/plugins/zsh-syntax-highlighting" ]]; then
  echo "installing missing syntax highlighting"
  git clone "https://github.com/zsh-users/zsh-syntax-highlighting" "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

# -------------------------------
# ZSH theme
# -------------------------------
if [ -e "${HOME}/${OHMYZSH_THEME}" ]; then
  echo -e "${YELLOW}"
  echo "Backing up existing OhMyZsh theme to ${HOME}/${OHMYZSH_THEME}.${TIMESTAMP}"
  echo -e "${NOCOLOR}"
  mv "${HOME}/${OHMYZSH_THEME}" "${HOME}/${OHMYZSH_THEME}.${TIMESTAMP}"
fi

echo -e "${YELLOW}"
echo "Installing ZSH theme 'jimigrunge'"
echo -e "${NOCOLOR}"
yes | cp -rf "${DOTFILEDIR}/${OHMYZSH_THEME}" "${HOME}/${OHMYZSH_THEME}"

# -------------------------------
# ZSH config
# -------------------------------
if [ -e "${HOME}/.zshrc" ]; then
  echo -e "${YELLOW}"
  echo "Backing up existing '.zshrc' to ${HOME}/.zshrc.${TIMESTAMP}"
  echo -e "${NOCOLOR}"
  mv "${HOME}/.zshrc" "${HOME}/.zshrc.${TIMESTAMP}"
fi

echo -e "${YELLOW}"
echo "Copying .zshrc to home directory."
echo -e "${NOCOLOR}"
cp "${DOTFILEDIR}/.zshrc" "${HOME}/.zshrc"

echo -e "${GREEN}"
echo "--------------------------------"
echo "- oh-my-zsh installed"
echo "--------------------------------"
echo -e "${NOCOLOR}"

echo -e "${BLUE}"
echo "--------------------------------"
echo "- Insure ZSH is default shell --"
echo "--------------------------------"
echo -e "${NOCOLOR}"

if [ "${SHELL}" != "$(which zsh)" ]; then
  sudo chsh -s "$(which zsh)"
  if [ "${SHELL}" != "$(which zsh)" ]; then
    # reverting back to the previous shell if there are any issues during the process
    echo -e "${RED}"
    echo "Error: issue switching default shell to ZSH"
    echo -e "${NOCOLOR}"
    # exec "$(which zsh)" -l
    # exec "$SHELL" -l
  fi
fi

if [ "${SHELL}" = "$(which zsh)" ]; then
  echo -e "${YELLOW}"
  echo "Zsh version: $(zsh --version)"
  echo -e "${NOCOLOR}"
fi

echo -e "${GREEN}"
echo "--------------------------------"
echo "- ZSH is your default shell    -"
echo "--------------------------------"
echo -e "${NOCOLOR}"
echo -e "${YELLOW}"
echo "You may need to log out and back int to load zsh"
echo -e "${NOCOLOR}"
