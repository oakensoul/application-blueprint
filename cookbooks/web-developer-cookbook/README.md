# web-developer-cookbook
[![Build Status](https://secure.travis-ci.org/turbine-web/web-developer-cookbook.png)](http://travis-ci.org/turbine-web/web-developer-cookbook)

Chef Cookbook for adding web development tools to an ubuntu server / vm.

## Requirements
This cookbook is built for use with Chef solo and Ubuntu.

## Usage
If you'd like to use this cookbook to add our web developer tools to your environment, all you really need
to do is update your `Berksfile` and add a few lines to your Vagrant file.

Because Berkshelf doesn't actually do recursive dependencies, you need to make sure you include all of the
dependencies from all of the cookbooks you're including. So, you'll want to add the following to your
`Berksfile`

````
cookbook 'web-developer-cookbook', git: 'https://github.com/turbine-web/web-developer-cookbook.git'
cookbook 'git', git: 'https://github.com/jssjr/git.git'
cookbook 'nodejs', git: 'https://github.com/redguide/nodejs.git'
cookbook 'grunt_cookbook', git: 'https://github.com/MattSurabian/grunt_cookbook.git'
cookbook 'chef-ruby-ppa', git: 'https://github.com/oakensoul/chef-ruby-ppa.git'
````

You will also need to add a "recipe" to your `Vagrantfile`. If you're looking for a Vagrantfile that could
be helpful to model after that takes advantage of this web developer cookbook, as well as our php-webserver
cookbook, please feel free to check out https://github.com/oakensoul/application-skeleton.

### Development Environment
In order to develop and test this module, you will need a handful of things installed. If you're working on
a mac, the steps below will help. If you're working on Windows, you may be out of luck until ChefDK is up
to speed for Windows.

#### Install ChefDK
Download and install from from http://www.getchef.com/downloads/chef-dk/mac/

#### Edit your bash profile
Your path settings can make or break the entire thing.

Open your `~/.bash_profile` and add the following:
* Alias rake to be wrapped with bundler
````
alias rake='bundle exec rake'
````
* Set your ruby and gems to use the embedded ChefDK paths
````
export PATH="/opt/chefdk/embedded/bin:$PATH
````
Last, but certainly not least, update folder permissions for ChefDK. There are other ways to do this,
but honestly, this really is the easiest way (as long as you aren't sharing your laptop or something).
Obviously, replace "youruser" with your username. If you don't know, type `whoami` in your shell.
````
sudo chown -R youruser:staff /opt/chefdk/
````

#### Vagrant 1.5
You will also need Vagrant 1.5.* installed.

You will also need two vagrant plugins:
* vagrant-berkshelf - `vagrant plugin install vagrant-berkshelf --plugin-version '>= 2.0.1'`

### Git Hooks
You should install the proper commit hooks for any commits, but executing `./install-git-hooks` or `VERBOSE=true ./install-git-hooks`

## Integration testing
This project uses Test Kitchen to provide integration testing and Rake as a build utility. By default when you run rake
it will provide usage commands. If you run `rake integration` it will perform the style and lint tasks and
if those pass it will then run kitchen test. The default integration tests will run against a local Vagrant Virtual Box.
If you wish to only run the tests against vagrant, you can run `rake integration:vagrant` or `rake integration:cloud` to
test against the ec2 cloud VM (see below for ec2 instructions).

Travis CI will use the `rake travis` command to test style, lint and then integration:cloud.

### AWS Cloud Integration
Note, if you wish to fork this project or test any changes to this project using EC2, you will need to update environment
variables on your system so that test-kitchen can connect to EC2. You will also need to make sure you have your EC2 SSH
key available for your CLI commands to use.

You will need to copy the ec2-config.conf.example file located in the `cloud-config` folder to ec2-config.conf. You
will then need to update all of the variables contained inside. Updating this folder will allow you to run the
travis_ec2_encrypt script. In order to use cloud integration, you will either need to copy the contents of that file
into your .bash_profile (or equivalent), or any time you open a shell you will need to run the following command:
`source ./cloud-config/ec2-config.conf`

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
This module is licensed using the Apache 2.0 License.

```
Copyright (C) 2014 Warner Bros. Entertainment Inc. Developed by Turbine, Inc.
Apache License, Version 2.0, January 2004, http://www.apache.org/licenses/
```
