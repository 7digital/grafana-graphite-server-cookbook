require 'serverspec'
set :backend, :exec

grafana_version = '2.1.3'

describe 'grafana' do
  describe docker_image("grafana/grafana:#{grafana_version}") do
    it { should exist }
  end

  describe docker_container('grafana') do
    it { should be_running }
    its(['HostConfig.PortBindings']) { should include '3000' }
    its(['HostConfig.PortBindings.3000.[0].HostPort']) { should eq '80' }
    it { should have_volume('/var/lib/grafana', '/var/grafana') }
    its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }
    its(['HostConfig.Links']) { should include '/graphite-statsd:/grafana/graphite-statsd' }
  end
end