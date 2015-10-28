docker_service 'default' do
  version '1.7.1' # Remove the version constraint when this PR gets merged into ServerSpec: https://github.com/mizzy/serverspec/pull/540
  provider Chef::Provider::DockerService::Systemd
  action [:create, :start]
end
