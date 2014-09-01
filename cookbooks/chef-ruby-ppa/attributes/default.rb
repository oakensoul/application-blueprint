#
# Cookbook Name:: chef-ruby-ppa
# Attributes:: default
#

# Select the provider that you've got configured
default['chef-ruby-ppa']['keyserver'] = 'keyserver.ubuntu.com'

default['chef-ruby-ppa']['repository'] = 'brightbox-ruby-ng'
default['chef-ruby-ppa']['key'] = 'C3173AA6'
default['chef-ruby-ppa']['uri'] = 'http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu'
