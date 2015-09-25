require 'serverspec'
set :backend, :exec

describe 'graphite' do
  describe docker_image('hopsoft/graphite-statsd') do
    it { should exist }
  end

  describe docker_container('graphite') do
    it { should be_running }
    its(['HostConfig.PortBindings']) { should include '8125/udp' }
    its(['HostConfig.PortBindings.8125/udp.[0].HostPort']) { should eq '8125' }
    it { should have_volume('/opt/graphite/storage/whisper', '/var/whisper') }
  end
end
