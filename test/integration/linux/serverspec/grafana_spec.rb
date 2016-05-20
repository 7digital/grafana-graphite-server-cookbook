require 'serverspec'
set :backend, :exec

cookbook_version = '2.4.2'

describe 'grafana' do
  describe docker_image("7d-grafana:#{cookbook_version}") do
    it { should exist }
  end

  describe docker_container('grafana') do
    it { should be_running }
    its(['HostConfig.PortBindings']) { should include '3000/tcp' }
    its(['HostConfig.PortBindings.3000/tcp.[0].HostPort']) { should eq '80' }
    it { should have_volume('/var/lib/grafana', '/var/grafana') }
    it { should have_volume('/var/log/grafana', '/var/log/grafana') }
    its(['HostConfig.RestartPolicy.Name']) { should eq 'always' }

    its(['HostConfig.Links']) do
      should include '/graphite-statsd:/grafana/graphite-statsd'
    end

    its(['Config.Env']) { should include 'GF_AUTH_ANONYMOUS_ENABLED=true' }
    its(['Config.Env']) { should include 'GF_AUTH_ANONYMOUS_ORG_ROLE=Admin' }
  end

  describe 'end-to-end' do
    describe 'allows anonymous login' do
      describe command('curl -v localhost 2>&1') do
        its(:stdout) { should match(/<title>Grafana/) }
      end
    end

    describe 'grants editor role to anonymous' do
      describe command('curl -v localhost 2>&1') do
        its(:stdout) { should match(/"orgRole":"Admin"/) }
      end
    end
  end
end
