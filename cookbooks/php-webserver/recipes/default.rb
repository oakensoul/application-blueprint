#
# Cookbook Name:: php-webserver
# Recipe:: default
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

%w(apt build-essential).each do |recipe|
  include_recipe recipe
end

phpversion = node['php_webserver']['php_version']

apt_repository node['php_webserver'][phpversion]['repository'] do
  uri node['php_webserver'][phpversion]['uri']
  distribution node['lsb']['codename']
  components ['main']
  keyserver node['php_webserver']['keyserver']
  key node['php_webserver'][phpversion]['key']
  notifies :run, 'execute[apt-get update]', :immediately
end

%w(apache2 apache2::mod_php5 apache2::mod_ssl apache2::mod_rewrite apache2::mod_headers composer).each do |recipe|
  include_recipe recipe
end

group node['apache']['group'] do
  name node['apache']['group']
  action :create
end

user node['apache']['user'] do
  group node['apache']['group']
  action :create
end

node['php_webserver']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

######## Log core files to syslog ##############################

# Using rsyslog.conf files since base Apache cookbook always assumes a file
# path, not a logger command

service 'rsyslog' do
  supports :status => true, :restart => true
end

template '/etc/rsyslog.d/35-apache.conf' do
  source 'rsyslog.d/35-apache.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[rsyslog]'
end

######## Log rotate ##############################

# create new template
cookbook_file '/etc/logrotate.d/apache2' do
  source 'logrotate.d/apache2'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# we want to run logrotate hourly for our webservers since we're doing size
# based rotation and our locak VM disks are small
execute 'logrotate-hourly' do
  command 'mv /etc/cron.daily/logrotate /etc/cron.hourly/logrotate'
  creates '/etc/cron.hourly/logrotate'
  notifies :create_if_missing, 'file[/etc/cron.daily/logrotate]', :immediately
end

# this only runs if the above resource was run (which should be once).  this
# just puts a placeholder file that does nothing in cron.daily to ensure the
# file is here so nothing puts a new copy in place
file '/etc/cron.daily/logrotate' do
  owner 'root'
  group 'root'
  mode '0755'
  content '# placeholder. Chef moved the original file here to /etc/cron.hourly/logrotate'

  action :nothing
end

######## Apache Customization ##############################

# remove the default alias.conf, so /icons/ is not browsable
file '/etc/apache2/mods-enabled/alias.conf' do
  action :delete
  notifies :restart, 'service[apache2]'
end

file '/etc/apache2/mods-available/alias.conf' do
  action :delete
end

execute 'force-apache-restart' do
  command '/usr/bin/service apache2 restart'
  action :nothing
end

#######################
# Install Pear Packages
#######################

node['php_webserver']['pear_packages'].each do |package, channel|
  php_pear package do
    channel channel if '' != channel
    action :install
  end
end
