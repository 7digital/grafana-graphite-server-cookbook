require 'serverspec'
require 'securerandom'
set :backend, :exec

cookbook_version = '3.4.2' # from metadata.rb

describe 'graphite' do
  describe docker_image("7d-graphite-statsd:#{cookbook_version}") do
    it { should exist }
  end

  describe docker_container('graphite-statsd') do
    it { should be_running }
    its(['HostConfig.PortBindings']) { should include '8125/udp' }
    its(['HostConfig.PortBindings']) { should include '8126/tcp' }
    its(['HostConfig.PortBindings.8125/udp.[0].HostPort']) { should eq '8125' }
    its(['HostConfig.PortBindings.8126/tcp.[0].HostPort']) { should eq '8126' }
    it { should have_volume('/opt/graphite/storage/whisper', '/var/whisper') }
    it { should have_volume('/var/log/graphite', '/var/log/graphite') }
    it { should have_volume('/var/log/statsd', '/var/log/statsd') }
    its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }

    its(['HostConfig.PortBindings']) { should include '80/tcp' }
    its(['HostConfig.PortBindings.80/tcp.[0].HostPort']) { should eq '8080' }
  end

  describe 'old stat cleanup' do
    `touch /var/whisper/new.file`
    `touch -t 200805101024 /var/whisper/old.file`
    `run-parts /etc/cron.daily`
    describe file('/var/whisper/new.file') do
      it { should be_file }
    end

    describe file('/var/whisper/old.file') do
      it { should_not be_file }
    end
  end

  describe 'end-to-end' do
    describe command('curl localhost:8080/dashboard') do
      its(:stdout) { should match(/Graphite Dashboard/) }
    end

    random_stat_name = SecureRandom.uuid
    get_url = 'localhost:8080/graphlot/rawdata?from=-1hour&until=-0hour&target=stats.gauges.' + random_stat_name

    describe command("curl -f '#{get_url}'") do
      `echo "#{random_stat_name}:100|g" | nc -u -q0 127.0.0.1 8125`
      sleep 8 # sleep so we can give it time to flush to disk
      its(:exit_status) { should eq 0 }
    end
  end
end
