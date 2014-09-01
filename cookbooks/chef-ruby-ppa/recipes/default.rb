#
# Cookbook Name:: chef-ruby-ppa
# Recipe:: default
#

include_recipe 'apt'

apt_repository "#{node['chef-ruby-ppa']['repository']}-#{node['lsb']['codename']}" do
  uri node['chef-ruby-ppa']['uri']
  distribution node['lsb']['codename']
  components ['main']
  keyserver node['chef-ruby-ppa']['keyserver']
  key node['chef-ruby-ppa']['key']
  action :add
  notifies :run, 'execute[apt-get update]', :immediately
end
