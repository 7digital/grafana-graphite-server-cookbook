directory '/opt/docker-images/graphite' do
  recursive true
end

cookbook_file '/opt/docker-images/graphite/Dockerfile' do
  source 'Dockerfile.graphite'
end

remote_directory '/opt/docker-images/graphite/graphite-configs' do
  source 'graphite-configs'
end

remote_directory '/opt/docker-images/graphite/statsd-configs' do
  source 'statsd-configs'
end

docker_image '7d-graphite-statsd' do
  source '/opt/docker-images/graphite'
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
