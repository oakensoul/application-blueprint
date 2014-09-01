require_relative '../spec_helper'

describe 'web-developer-cookbook::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes web-developer-cookbook::git cookbook' do
    expect(chef_run).to include_recipe('web-developer-cookbook::git')
  end

  it 'includes web-developer-cookbook::nodejs cookbook' do
    expect(chef_run).to include_recipe('web-developer-cookbook::nodejs')
  end

  it 'includes web-developer-cookbook::grunt cookbook' do
    expect(chef_run).to include_recipe('web-developer-cookbook::grunt')
  end

  it 'includes web-developer-cookbook::casperjs cookbook' do
    expect(chef_run).to include_recipe('web-developer-cookbook::casperjs')
  end

end

# it 'includes web-developer-cookbook::ruby cookbook' do
#   expect(chef_run).to include_recipe('web-developer-cookbook::ruby')
# end
