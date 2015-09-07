require 'serverspec'
set :backend, :exec

describe 'graphite' do
  describe docker_image('hopsoft/graphite-statsd') do
    it { should exist }
  end

  describe docker_container('graphite') do
    it { should be_running }
  end
end
