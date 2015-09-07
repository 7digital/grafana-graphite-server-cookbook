docker_service 'default' do
  provider Chef::Provider::DockerService::Systemd
  action [:create, :start]
end
