#
# Cookbook Name:: web-developer-cookbook
# Recipe:: casperjs
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

# Using the git resource to pull casperjs from GitHub
# -- http://docs.opscode.com/chef/resources.html#git
git '/usr/local/src/casperjs' do
  repository 'https://github.com/n1k0/casperjs.git'
  revision node['casperjs']['revision']
  action :sync
end

# Create a sym link in /usr/local/bin to casperjs
link '/usr/local/bin/casperjs' do
  to '/usr/local/src/casperjs/bin/casperjs'
end
