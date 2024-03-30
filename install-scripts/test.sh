#!/usr/bin/env bash

if ! [ "$(xcode-select -p)" ]; then
  echo "xcode not found"
else
  echo "xcode found"
fi
