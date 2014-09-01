require_relative '../spec_helper'

describe 'web-developer-cookbook::casperjs' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'sync casperjs from github' do
    expect(chef_run).to sync_git('/usr/local/src/casperjs').with(:repository => 'https://github.com/n1k0/casperjs.git')
  end

  it 'creates a /usr/local/src link to casperjs' do
    link = chef_run.link('/usr/local/bin/casperjs')
    expect(link).to link_to('/usr/local/src/casperjs/bin/casperjs')
  end

end
