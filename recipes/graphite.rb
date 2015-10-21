image_build_folder = '/opt/docker-images/graphite'

directory image_build_folder do
  recursive true
end

cookbook_file "#{image_build_folder}/Dockerfile" do
  source 'Dockerfile.graphite'
end

remote_directory "#{image_build_folder}/graphite-configs" do
  source 'graphite-configs'
end

remote_directory "#{image_build_folder}/statsd-configs" do
  source 'statsd-configs'
end

docker_image '7d-graphite-statsd' do
  source image_build_folder
  nocache true
  #todo: tag w/the cookbook version & use below?
  action :build_if_missing
end

docker_container 'graphite-statsd' do
  repo '7d-graphite-statsd'
  port '8125:8125/udp'
  binds ['/var/whisper:/opt/graphite/storage/whisper']
  restart_policy 'always'
end
