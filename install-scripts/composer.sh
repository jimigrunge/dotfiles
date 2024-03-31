#!/usr/bin/env bash

echo -e "${BLUE}"
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
    php composer-setup.php #--quiet
    RESULT=$?
    rm composer-setup.php
    mv composer.phar "$HOME/bin/composer"
    export PATH=${HOME}/bin:${PATH}
    echo "composer setup result: ${RESULT}"

    export PATH=${COMPOSER_DIR}/vendor/bin:${CONFIG_HOME}/composer/vendor/bin:${PATH}
    echo -e "${GREEN}"
    echo "Composer install complete"
    echo -e "${NOCOLOR}"
  fi
fi

if [ -x "$(command -v composer)" ]; then
  echo -e "${BLUE}"
  echo "--------------------------------"
  echo "- Installing PHP tool libraries "
  echo "--------------------------------"
  echo -e "${NOCOLOR}"

  if ! [ -x "$(command -v phpcs)" ]; then
    echo " installing phpcs and phpcbf"
    composer global require --no-interaction "squizlabs/php_codesniffer=*"
  fi

  if ! [ -x "$(command -v php-cs-fixer)" ]; then
    echo " installing php-cs-fixer"
    composer global require --no-interaction "friendsofphp/php-cs-fixer"
  fi

  if ! [ -x "$(command -v phpmd)" ]; then
    echo " installing phpmd"
    composer global require --no-interaction "phpmd/phpmd"
  fi

  if ! [ -x "$(command -v phpunit)" ]; then
    echo " installing phpunit"
    composer global require --no-interaction "phpunit/phpunit"
  fi

  if ! [ -x "$(command -v phive)" ]; then
    cd "${COMPOSER_DIR}"

    echo " installing phpDocumentor"
    phive install "phpDocumentor"

    export PATH=${HOME}/.composer/tools:${PATH}

    cd "${DOTFILEDIR}"
  fi

  echo -e "${GREEN}"
  echo "--------------------------------"
  echo "----- PHP tools installed ------"
  echo "--------------------------------"
  echo -e "${NOCOLOR}"
fi
