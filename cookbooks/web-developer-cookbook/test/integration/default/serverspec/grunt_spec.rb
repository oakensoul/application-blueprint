require_relative 'spec_helper'

describe 'web-developer-cookbook::grunt' do

  it 'should install grunt' do
    cmd = command 'grunt --version'
    expect(cmd).to return_exit_status 0
  end

end
