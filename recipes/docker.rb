docker_service 'default' do
  version '1.7.1' # ServerSpec doesn't fully support Docker 1.8+ yet (different 'docker inspect' response)
  provider Chef::Provider::DockerService::Systemd
  action [:create, :start]
end
