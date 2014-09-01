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

SSH_KEY_PATH=$1
CONFIG_FILE=./cloud-config/ec2-config.conf

if [[ -z "$SSH_KEY_PATH" ]]; then
  echo "You must provide the SSH Key to the script. For example:"
  echo "$ ./travis_ec2_encrypt.sh ~/.ssh/my_private_key"
  exit
elif [ ! -s "$SSH_KEY_PATH" ]; then
  echo "File $SSH_KEY_PATH does not exist or is empty."
  exit
elif [ ! -s "$CONFIG_FILE" ]; then
  echo "Cloud configuration config file is required, but not found at:"
  echo "  $CONFIG_FILE"
  exit
elif [[ ! $(which travis) ]]; then
  echo "This script requires that you have the travis gem installed."
  echo "Please install the required ruby gems by running:"
  echo "$ bundle install"
  exit
fi

base64 --break 64 ${SSH_KEY_PATH} > ${SSH_KEY_PATH}_base64

travis login --pro --auto

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
travis encrypt AWS_SECURITY_GROUPS=$AWS_SECURITY_GROUPS --add
travis encrypt LOCAL_SSH_KEY_FILE_FOR_EC2=$LOCAL_SSH_KEY_FILE_FOR_EC2 --add
travis encrypt $HIPCHAT_API_TOKEN@"$HIPCHAT_ROOM" --add notifications.hipchat
