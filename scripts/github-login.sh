#!/bin/bash

eval `ssh-agent`
sleep 2

ssh-add --apple-use-keychain ~/.ssh/github_rsa
sleep 2

ssh -T git@github.com

