require_relative '../spec_helper'

describe 'web-developer-cookbook::git' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs git::default' do
    expect(chef_run).to include_recipe('git::default')
  end

end
