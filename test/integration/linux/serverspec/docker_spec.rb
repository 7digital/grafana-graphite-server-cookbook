require 'serverspec'
set :backend, :exec

describe 'docker setup' do
  describe service('docker') do
    it { should be_running }
  end
end
