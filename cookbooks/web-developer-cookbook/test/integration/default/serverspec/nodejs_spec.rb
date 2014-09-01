require_relative 'spec_helper'

describe 'web-developer-cookbook::nodejs' do

  it 'should install nodejs' do
    cmd = command 'nodejs -v'
    expect(cmd).to return_exit_status 0
  end

  it 'should install npm' do
    cmd = command 'npm -v'
    expect(cmd).to return_exit_status 0
  end

  it 'should install csslint' do
    cmd = command 'csslint --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install jslint' do
    cmd = command 'jslint --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install coffee' do
    cmd = command 'coffee --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install coffeelint' do
    cmd = command 'coffeelint --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install jsonlint' do
    cmd = command 'jsonlint --help'
    expect(cmd).to return_exit_status 0
  end

  it 'should install mocha' do
    cmd = command 'mocha --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install phantomjs' do
    cmd = command 'phantomjs --version'
    expect(cmd).to return_exit_status 0
  end

  it 'should install chaijs' do
    cmd = command 'npm list chai -g'
    expect(cmd).to return_exit_status 0
  end

end
