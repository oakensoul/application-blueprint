require_relative '../spec_helper'

describe 'web-developer-cookbook::ruby' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs ruby ppa' do
    expect(chef_run).to include_recipe('chef-ruby-ppa::default')
  end

  it 'should install ruby' do
    expect(chef_run).to install_apt_package('ruby2.1')
  end

  it 'should install compass' do
    expect(chef_run).to install_gem_package('compass').with(:version => '~> 0.12.6')
  end

  it 'should install bundler' do
    expect(chef_run).to install_gem_package('bundler').with(:version => '~> 1.5.2')
  end

end
