require_relative '../spec_helper'

describe 'web-developer-cookbook::nodejs' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs nodejs::nodejs' do
    expect(chef_run).to include_recipe('nodejs::nodejs')
  end

  it 'installs nodejs::npm' do
    expect(chef_run).to include_recipe('nodejs::npm')
  end

  it 'installs apt_package libfontconfig' do
    expect(chef_run).to install_apt_package('libfontconfig')
  end

  it 'installs apt_package libfontconfig-dev' do
    expect(chef_run).to install_apt_package('libfontconfig-dev')
  end

  it 'installs apt_package libfreetype6-dev' do
    expect(chef_run).to install_apt_package('libfreetype6-dev')
  end

end
