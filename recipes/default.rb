#
# Cookbook Name:: application-blueprint
# Recipe:: default
#
# Copyright (C) 2013, Robert G. Johnson Jr. @Oakensoul and Project Contributors listed in README.md
#
# Link: https://github.com/web-masons/application-blueprint for the canonical source repository
# License: http://opensource.org/licenses/Apache-2.0
# Package: Cornerstone
#

include_recipe 'cornerstone-vagrant'

gem_package 'bootstrap-sass'
