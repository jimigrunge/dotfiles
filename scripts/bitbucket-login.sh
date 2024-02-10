#!/bin/bash

eval `ssh-agent`
sheep 2

# ssh-add -K ~/.ssh/bitbucket_jgrundner_rsa
ssh-add --apple-use-keychain ~/.ssh/bitbucket_jgrundner_rsa
sleep 2

ssh -T git@bitbucket.org
