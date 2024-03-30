#!/usr/bin/env bash

echo -e "${YELLOW}"
echo "--------------------------------"
echo "------- Composer Setup ---------"
echo "--------------------------------"
echo -e "${NOCOLOR}"

if ! [ -x "$(command -v composer)" ]; then
  echo -e "${RED}"
  echo "Composer not found, installing from source"
  echo -e "${NOCOLOR}"

  EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

  if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
    echo -e "${RED}"
    echo "ERROR: Invalid composer installer checksum"
    echo "Composer install failed, PHP tools not installed"
    echo -e "${NOCOLOR}"
    rm composer-setup.php
  else
    php composer-setup.php --quiet
    RESULT=$?
    rm composer-setup.php
    echo $RESULT

    export PATH=${COMPOSER_DIR}/vendor/bin:${CONFIG_HOME}/composer/vendor/bin:${PATH}
    echo -e "${GREEN}"
    echo "Composer install complete"
    echo -e "${NOCOLOR}"
  fi
fi

if [ -x "$(command -v composer)" ]; then
  echo "--------------------------------"
  echo "- Installing PHP tool libraries "
  echo "--------------------------------"

  echo " installing phpcs and phpcbf"
  composer global require "squizlabs/php_codesniffer=*"

  echo " installing php-cs-fixer"
  composer global require "friendsofphp/php-cs-fixer"

  echo " installing phpmd"
  composer global require "phpmd/phpmd"

  echo " installing phpunit"
  composer global require "phpunit/phpunit"

  if ! [ -x "$(command -v phive)" ]; then
    cd "${COMPOSER_DIR}"

    echo " installing phpDocumentor"
    phive install "phpDocumentor"

    export PATH=${HOME}/.composer/tools:${PATH}

    cd "${DOTFILEDIR}"
  fi

  echo "--------------------------------"
  echo -e "${GREEN} PHP tools installed ${NOCOLOR}"
  echo "--------------------------------"
fi
