image_build_folder = '/opt/docker-images/grafana'
image_name = '7d-grafana'

directory image_build_folder do
  recursive true
end

cookbook_file "#{image_build_folder}/Dockerfile" do
  source 'Dockerfile.grafana'
end

docker_image image_name do
  source image_build_folder
  nocache true
  action :build_if_missing
end

docker_container 'grafana' do
  repo image_name
  port '80:3000'
  binds [
    '/var/grafana:/var/lib/grafana',
    '/var/log/grafana:/var/log/grafana'
  ]
  links ['graphite-statsd']
  restart_policy 'always'
end
