#!/usr/bin/env bash

echo -e "${YELLOW}"
echo "--------------------------------"
echo "--------- Node Setup -----------"
echo "--------------------------------"
echo -e "${NOCOLOR}"

echo ""
echo "--------------------------------"
echo "- Fix NPM directory permissions "
echo "--------------------------------"
echo ""
mkdir -pv "${NPM_DIR}"
npm config set prefix "${NPM_DIR}"
export PATH=${NPM_DIR}/bin:${PATH}
echo ""
echo "--------------------------------"
echo "-- Installing Node Libraries ---"
echo "--------------------------------"

echo "Checking for n npm version manager"
if ! [ -x "$(command -v n)" ]; then
  echo 'Attempting to Install n.' >&2
  npm install -g n
fi

echo "Checking for neovim bridge"
if ! [ -x "$(command -v neovim-node-host)" ]; then
  echo 'Attempting to Install neovim bridge.' >&2
  npm install -g neovim
fi

echo "Checking for typescript"
if ! [ -x "$(command -v tsc)" ]; then
  echo 'Attempting to Install typescript.' >&2
  npm install -g typescript
fi

echo "--------------------------------"
echo -e "${GREEN} Node libraries installed ${NOCOLOR}"
echo "--------------------------------"
