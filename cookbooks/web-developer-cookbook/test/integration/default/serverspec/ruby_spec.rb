require_relative 'spec_helper'

describe 'web-developer-cookbook::ruby' do

  it 'should install ruby ppa' do
    cmd = command 'casperjs --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install ruby' do
    cmd = command 'ruby --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install bundler' do
    cmd = command 'bundler --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install compass' do
    cmd = command 'compass --version'
    expect(cmd).to return_exit_status 0
  end

end
