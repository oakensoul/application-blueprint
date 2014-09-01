#
# Cookbook Name:: php-webserver
# Attributes:: default
#
# Copyright (C) 2014 Warner Bros. Entertainment Inc. Developed by Turbine, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# php_version is used to look up the correct ppa repository, there needs
# to be a corresponding set of repository, key, and uri for any version
# of PHP that is to be installed
node.default['php_webserver']['php_version'] = '5.4'

node.default['php_webserver']['keyserver'] = 'keyserver.ubuntu.com'

node.default['php_webserver']['5.5']['repository'] = 'ondrej'
node.default['php_webserver']['5.5']['key'] = 'E5267A6C'
node.default['php_webserver']['5.5']['uri'] = 'http://ppa.launchpad.net/ondrej/php5/ubuntu/'

node.default['php_webserver']['5.4']['repository'] = 'ondrej-php54'
node.default['php_webserver']['5.4']['key'] = 'E5267A6C'
node.default['php_webserver']['5.4']['uri'] = 'http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu'

# default packages to install
node.default['php_webserver']['packages'] = [
  'gettext',
  'php5-curl',
  'php5-mysqlnd',
  'php5-gd',
  'php5-memcached',
  'php5-memcache',
  'php5-dev', # needed for oci8 pecl install
  'php-apc',
  'php5-intl',
  'php-pear',
  'php5-gmp',
  'language-pack-fr',
  'language-pack-de'
]

# default pear packages to install
node.default['php_webserver']['pear_packages'] = {
  # Package => Channel
}
