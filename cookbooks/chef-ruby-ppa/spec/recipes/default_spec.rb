require_relative '../spec_helper'

describe 'chef-ruby-ppa::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes chef-ruby-ppa::default' do
    expect(chef_run).to include_recipe('chef-ruby-ppa::default')
  end

  # fairly useless test overall, i'm not sure how to get chef spec
  # to test that apt_repository was actually called

end
