image_build_folder = '/opt/docker-images/graphite'
image_name = '7d-graphite-statsd'

directory image_build_folder do
  recursive true
end

cookbook_file "#{image_build_folder}/Dockerfile" do
  source 'Dockerfile.graphite'
end

remote_directory "#{image_build_folder}/graphite-backend-configs" do
  source 'graphite-backend-configs'
end

remote_directory "#{image_build_folder}/graphite-web-configs" do
  source 'graphite-web-configs'
end

remote_directory "#{image_build_folder}/statsd-configs" do
  source 'statsd-configs'
end

docker_image image_name do
  source image_build_folder
  nocache true
  action :build_if_missing
end

docker_container 'graphite-statsd' do
  repo image_name
  port [
    '8125:8125/udp',
    '8080:80' # For integration tests
  ]
  binds ['/var/whisper:/opt/graphite/storage/whisper'] # This mount point is needed in the whisper cleanup cron job
  restart_policy 'always'
end

cookbook_file '/etc/cron.daily/whisper-cleanup' do
  source 'whisper-cleanup'
  mode 0755
end
