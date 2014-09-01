#
# Cookbook Name:: web-developer-cookbook
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

node.default['web-developer-cookbook']['ruby']['package'] = 'ruby2.1'

node.default['web-developer-cookbook']['ruby']['gems'] = [
  { 'name' => 'bundler', 'version' => '~> 1.5.2' },
  { 'name' => 'compass', 'version' => '~> 0.12.6' }
]

node.default['web-developer-cookbook']['npm_packages'] = [
  { 'name' => 'csslint', 'version' => '~0.10.0' },
  { 'name' => 'jslint', 'version' => '~0.5.2' },
  { 'name' => 'coffee-script', 'version' => '~1.7.1' },
  { 'name' => 'jsonlint', 'version' => '~1.6.0' },
  { 'name' => 'mocha', 'version' => '~1.20.1' },
  { 'name' => 'chai', 'version' => '~1.9.1' },
  { 'name' => 'coffeelint', 'version' => '~1.5.2' },
  { 'name' => 'phantomjs', 'version' => '~1.9.7' }
]

## CaserpJS Configuration

# We're loading CasperJS from GitHub, so the revision should be the desired release
node.default['casperjs']['revision'] = '1.1-beta3'
