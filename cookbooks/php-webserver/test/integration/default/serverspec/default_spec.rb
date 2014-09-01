require 'spec_helper'

describe 'php-webserver::default' do

  it 'should install apache' do
    expect(service 'apache2').to be_running
  end

  it 'should be listening on port 80' do
    expect(port 80).to be_listening
  end

  it 'should be listening on port 443' do
    expect(port 443).to be_listening
  end

  it 'should delete mods enabled alias.conf' do
    expect(File).not_to exist('/etc/apache2/mods-enabled/alias.conf')
  end

  it 'should delete mods available alias.conf' do
    expect(File).not_to exist('/etc/apache2/mods-available/alias.conf')
  end

  it 'should install php' do
    cmd = command 'php --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install php ~> 5.4' do
    cmd = command 'php --version'
    expect(cmd.stdout).to match 'PHP 5.4'
  end

  %w(gettext php5-curl php5-mysqlnd php5-gd php5-memcached php5-memcache php5-dev php-apc php5-intl php-pear php5-gmp language-pack-fr language-pack-de).each do |pkg|
    it 'should install package ' << pkg do
      expect(package pkg).to be_installed
    end
  end

  it 'should install php package mongo' do
    cmd = command 'pecl info mongo'
    expect(cmd).to return_exit_status 0
  end

end
