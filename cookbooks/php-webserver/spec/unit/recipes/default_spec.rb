require 'spec_helper'

describe 'php-webserver::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  # it 'installs sample package' do
  #   expect(chef_run).to install_package 'vim'
  # end

  before :each do
    stub_command("php -m | grep 'Phar'").and_return true
  end

  %w(apache2 php5 php5-cgi libapache2-mod-php5 build-essential php5-cli php-pear).each do |pkg|
    it "installs #{pkg}" do
      expect(chef_run).to install_package pkg
    end
  end

  %w(apache2 apache2::mod_ssl apache2::mod_rewrite apache2::mod_headers).each do |recipe|
    it "includes recipe #{recipe}" do
      expect(chef_run).to include_recipe(recipe)
    end
  end

end
