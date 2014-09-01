require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
    c.path = '/sbin:/usr/sbin'
  end
end

# Required for Growl notifications to work properly
def gem_available?(name)
  Gem::Specification.find_by_name(name)
rescue Gem::LoadError
  false
rescue
  Gem.available?(name)
end

if gem_available?('safe_yaml')
  SafeYAML::OPTIONS[:deserialize_symbols] = true
  SafeYAML::OPTIONS[:default_mode] = 'unsafe'
end
