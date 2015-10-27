require 'serverspec'
require 'securerandom'
set :backend, :exec

describe 'graphite' do
  describe docker_image('7d-graphite-statsd') do
    it { should exist }
  end

  describe docker_container('graphite-statsd') do
    it { should be_running }
    its(['HostConfig.PortBindings']) { should include '8125/udp' }
    its(['HostConfig.PortBindings.8125/udp.[0].HostPort']) { should eq '8125' }
    it { should have_volume('/opt/graphite/storage/whisper', '/var/whisper') }
    its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }

    # For integration tests, normal grafana -> graphite communication can happen via a Docker link
    its(['HostConfig.PortBindings']) { should include '80' }
    its(['HostConfig.PortBindings.80.[0].HostPort']) { should eq '8080' }
  end

  describe 'end-to-end' do
    describe command('curl localhost:8080/dashboard') do
      its(:stdout) { should match (/Graphite Dashboard/) }
    end

    random_stat_name = SecureRandom.uuid
    describe command("curl -f 'localhost:8080/graphlot/rawdata?from=-24hour&until=-0hour&target=stats.gauges.#{random_stat_name}'") do
      `echo "#{random_stat_name}:100|g" | nc -u -q0 127.0.0.1 8125`
      sleep 8 # sleep so we can give it time to flush to disk
      its(:exit_status) { should eq 0 }
    end
  end
end
