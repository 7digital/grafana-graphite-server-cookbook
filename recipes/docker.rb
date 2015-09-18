docker_service 'default' do
  version '1.7.1'
  provider Chef::Provider::DockerService::Systemd
  action [:create, :start]
end
