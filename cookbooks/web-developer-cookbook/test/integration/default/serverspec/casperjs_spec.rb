require_relative 'spec_helper'

describe 'web-developer-cookbook::casperjs' do

  it 'should install casperjs' do
    cmd = command 'casperjs --version'
    expect(cmd).to return_exit_status 0
  end

end
