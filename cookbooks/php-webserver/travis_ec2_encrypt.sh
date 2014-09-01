#!/bin/bash
# travis_ec2_encrypt.ssh
#
# Encrypts private SSH keys for use in .travis.yml.
#
# Based on the following gists:
#   https://gist.github.com/lukewpatterson/4242707
#   https://gist.github.com/davestern/9377538
#
# Also see the travis documentation:
#   http://docs.travis-ci.com/user/build-configuration/#Secure-environment-variables
 
# Usage:
# Go to your git project:
#   cd my_project
# Then run:
#   ./travis_ec2_encrypt.sh ~/.ssh/my_private_key


# TODO: Move this into the Rake file
#
# In order for this script to fully work, you need to set the following
# environment variables:
#
# AWS_ACCESS_KEY
# AWS_SECRET_ACCESS_KEY
# AWS_KEYPAIR_NAME
# AWS_USERNAME
# EC2_SSH_KEY_PATH

SSH_KEY_PATH=$1
 
echo base64 encoding ssh key: $SSH_KEY_PATH
base64 --break 64 ${SSH_KEY_PATH} > ${SSH_KEY_PATH}_base64
 
if [[ ! $(which travis) ]]
then
  echo installing travis cli tool
  gem install travis
fi
 
echo logging in to travis
travis login --pro --auto
 
echo encrypting environment variables for .travis.yml
for l in $(cat ${SSH_KEY_PATH}_base64);
do
  LINE=$(grep -n $l ${SSH_KEY_PATH}_base64 | cut -d: -f1);
  travis encrypt EC2_KEY_CHUNK_$LINE=$l --add
#  echo "    - secure: $(travis encrypt \"EC2_KEY_CHUNK_$LINE=$l\")";
done

travis encrypt AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID --add
travis encrypt AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY --add
travis encrypt AWS_KEYPAIR_NAME=$AWS_KEYPAIR_NAME --add
travis encrypt AWS_USERNAME=$AWS_USERNAME --add
travis encrypt EC2_SSH_KEY_PATH=$EC2_SSH_KEY_PATH --add
travis encrypt $HIPCHAT_API_TOKEN@"$HIPCHAT_ROOM" --add notifications.hipchat
