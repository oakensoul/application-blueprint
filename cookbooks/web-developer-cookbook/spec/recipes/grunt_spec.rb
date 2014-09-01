require_relative '../spec_helper'

describe 'web-developer-cookbook::grunt' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs grunt_cookbook::default' do
    expect(chef_run).to include_recipe('grunt_cookbook::default')
  end

end
