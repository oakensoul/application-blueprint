# chef-ruby-ppa
[![Build Status](https://secure.travis-ci.org/oakensoul/chef-ruby-ppa.png)](http://travis-ci.org/oakensoul/chef-ruby-ppa)

Chef Cookbook for installing a system Ruby using PPA.

## Requirements
This cookbook is built for use with Chef solo and Ubuntu.

### Development Requirements
In order to develop and test this module, you will need a handful of gems installed.
* ChefDK - http://www.getchef.com/downloads/chef-dk/
* Travis - `chef gem install travis`
* Travis Lint - `chef gem install travis-lint`
* Kitchen EC2 - `chef gem install kitchen-ec2`
* Unicode - `chef gem install unf`
* Git-Precommit -- `chef gem install git-precommit`

You will also need Vagrant 1.5.* installed.

You will also need the berkshelf vagrant plugins:
* vagrant-berkshelf - `vagrant plugin install vagrant-berkshelf --plugin-version '>= 2.0.1'`

### Environment Variables
In order to use the cloud integration, or to set up travis, you will need to have the environment variables below set.
You will need to copy the ec2-config.conf.example file located in the `cloud-config` folder to ec2-config.conf. You
will then need to update all of the variables contained inside. Updating this folder will allow you to run the
travis_ec2_encrypt script. In order to use cloud integration, you will either need to copy the contents of that file
into your .bash_profile (or equivalent), or any time you open a shell you will need to run the following command:
`source ./cloud-config/ec2-config.conf`

### Git Hooks
You should install the proper commit hooks for any commits, but executing `./install-git-hooks` or `VERBOSE=true ./install-git-hooks`

## Integration testing
This project uses Test Kitchen to provide integration testing and Rake as a build utility. By default when you run rake
it will provide usage commands. If you run `rake integration` it will perform the style and lint tasks and
if those pass it will then run kitchen test. The default integration tests will run against a local Vagrant Virtual Box.
If you wish to only run the tests against vagrant, you can run `rake integration:vagrant` or `rake integration:cloud` to
test against the ec2 cloud VM.

Travis CI will use the `rake travis` command to test style, lint and then integration:cloud.

Note, if you wish to fork this project or test any changes to this project using EC2, you will need to update environment
variables on your system so that test-kitchen can connect to EC2. You will also need to make sure you have your EC2 SSH
key available for your CLI commands to use.

You should have the following environment variables set:
* 'AWS_ACCESS_KEY_ID' - The AWS Access Key ID provided when you set up IAM
* 'AWS_SECRET_ACCESS_KEY' - The AWS Secret Access Key provided when you set up IAM
* 'AWS_KEYPAIR_NAME' - This is the SSH key name that you will have preloaded on your AWS VM.
* 'AWS_USERNAME' - This should likely be 'ubuntu' if you're using a standard ubuntu AMI.
* 'AWS_SECURITY_GROUPS' - Traffic restriction group if you use it to restrict access to your AWS instances.
* 'LOCAL_SSH_KEY_FILE_FOR_EC2' - This should be the name of your key file, it is expected to live in ~/.ssh/

If you are connecting to HipChat, you will need to set the following:
* 'HIPCHAT_API_TOKEN' - Your HipChat token can be created from the HipChat web admin panel.
* 'HIPCHAT_ROOM' - The name of the room that you wish for any travis messaging to be sent to.

## Travis CI
This project uses Travis CI for build and CI.

The same environment variables above are already encrypted in the travis.yml file for the project using the
travis_ec2_encrypt shell script. The values in source control are for accessing the project owner's EC2 account. This
allows the Travis CI system to remotely spin up an EC2 instance and deploy the cookbook. If you wish to fork this repo,
then you will need to regenerate the encrypted values using the enclosed travis_ec2_encrypt script.

## Contributing
* [Getting Started](CONTRIBUTING.md)
* [Bug Reports](CONTRIBUTING.md#bug-reports)
* [Feature Requests](CONTRIBUTING.md#feature-requests)
* [Pull Requests](CONTRIBUTING.md#pull-requests)

# LICENSE
This repository is licensed using the Apache 2.0 License.

```
Copyright (C) 2014 Robert Gunnar Johnson Jr.
Apache License, Version 2.0, January 2004, http://www.apache.org/licenses/
```
