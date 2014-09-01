require_relative 'spec_helper'

describe 'web-developer-cookbook::git' do

  it 'should install git' do
    cmd = command 'git --version'
    expect(cmd).to return_exit_status 0
  end

end
