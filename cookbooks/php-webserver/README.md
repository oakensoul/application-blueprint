PHP Webserver
=================

This cookbook configures a basic web server using Apache 2.4 and PHP 5.5, suitable for deploying PHP applications onto.

Requirements
------------

### Platform:

* Ubuntu 12.04

### Cookbooks:

* apt
* built-essential
* apache
* php

Attributes
----------

See `attributes/default.rb` for all default values.

* `node.default['php_webserver']['php_version']` - Version of PHP to install (Default: 5.5)
* `node.default['php_webserver']['keyserver']` - Where to retrieve the key for the PPA
* `node.default['php_webserver']['5.5']['repository']` - The PPA repository to pull from for PHP 5.5
* `node.default['php_webserver']['5.5']['key']` - The ID to look up in the keyserver for the PGP key
* `node.default['php_webserver']['5.5']['uri']` - Location that the PPA is at for PHP 5.5
* `node.default['php_webserver']['5.4']['repository']` - The PPA repository to pull from for PHP 5.4
* `node.default['php_webserver']['5.4']['key']` - The ID to look up in the keyserver for the PGP key
* `node.default['php_webserver']['5.4']['uri']` - Location that the PPA is at for PHP 5.4
* `node.default['php_webserver']['packages']` - Array of packages to install
* `node.default['php_webserver']['pear_packages']` - Hash of pear packages to install. Expects: 'package' => 'channel'. If channel is empty, doesn't set it

Recipes
-------

### php-webserver::default

The default php-webserver recipe will install a configured version of PHP, and a version of Apache that is required by that version of PHP. By default, this will install PHP 5.5 and Apache 2.4.

The cookbook requires a platform of Ubuntu 12.04, other platforms are not currently supported.

Testing
-------

[![Build Status](https://travis-ci.org/turbine-web/php-webserver.png?branch=master)](https://travis-ci.org/turbine-web/php-webserver)

The cookbook provides the following Rake tasks for testing:

    rake acceptance                   # Alias for kitchen:all
    rake foodcritic                   # Run foodcritic lint checks
    rake integration                  # Run all tests except Kitchen (default t...
    rake kitchen:all                  # Run all test instances
    rake kitchen:default-centos-64    # Run default-centos-64 test instance
    rake kitchen:default-ubuntu-1204  # Run default-ubuntu-1204 test instance
    rake lint                         # Run linters
    rake rubocop                      # Run Rubocop lint checks
    rake spec                         # Run chefspec tests
    rake test                         # Run all tests

Docker Prep for OSX
-------------------

Currently, the vagrant driver is being used. Follow the manual install steps below to set up vagrant for use with test-kitchen.
If using the docker driver, then DVM must be installed to run test-kitchen using docker. To install DVM

1. Install DVM: https://github.com/fnichol/dvm
2. DVM up.
3. Kitchen is ready to go!

Vagrant Prep for OSX
--------------------

These instructions are meant for Mac OSX users that wish to sync down the repository and vagrant up a vm for their personal use, or manual testing. Note that the instructions require at least __Mac OS X 10.9.x__ or, more simply, __OS X Mavericks__. Older versions of OS X may not function as expected.

First, ensure vagrant is installed on the machine. You can grab the latest vagrant version on [their site](http://www.vagrantup.com/). Then, follow these steps in a terminal:

```sh
# Clone the repository
git clone git@github.com:turbine-web/php-webserver.git
cd ./php-webserver

# Ensure brew is up-to-date and working correctly
brew update
brew doctor

# Install rbenv
brew install rbenv
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Install ruby build
brew install ruby-build

# Install ruby version locally
rbenv install 2.0.0-p481
rbenv rehash

# Install bundler
gem install bundler
rbenv rehash
bundle install

# Install the vagrant berkshelf plugin
vagrant plugin install vagrant-berkshelf --plugin-version '>= 2.0.1'

# Run tests on the env
bundle exec rake test
kitchen test
```

License
------------------

Copyright:: 2014, Warner Bros. Entertainment Inc. Developed by Turbine, Inc.

Based on https://github.com/charlesjohnson/skeleton-cookbook

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
