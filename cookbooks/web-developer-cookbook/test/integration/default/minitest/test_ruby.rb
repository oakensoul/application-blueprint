require 'minitest/autorun'

describe 'default' do
  it 'has created brightbox-ruby-ng-precise.list' do
    assert File.exist?('/etc/apt/sources.list.d/brightbox-ruby-ng-precise.list')
  end
end
