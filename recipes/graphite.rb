image_build_folder = '/opt/docker-images/graphite'

directory image_build_folder do
  recursive true
end

cookbook_file "#{image_build_folder}/Dockerfile" do
  source 'Dockerfile.graphite'
end

remote_directory "#{image_build_folder}/graphite-backend-configs" do
  source 'graphite-backend-configs'
end

remote_directory "#{image_build_folder}/statsd-configs" do
  source 'statsd-configs'
end

docker_image '7d-graphite-statsd' do
  source image_build_folder
  nocache true
  action :build_if_missing
end

docker_container 'graphite-statsd' do
  repo '7d-graphite-statsd'
  port [
    '8125:8125/udp',
    '8080:80' # For integration tests
  ]
  binds ['/var/whisper:/opt/graphite/storage/whisper']
  restart_policy 'always'
end
