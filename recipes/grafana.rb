image_build_folder = '/opt/docker-images/grafana'
image_name = '7d-grafana'

directory image_build_folder do
  recursive true
end

cookbook_file "#{image_build_folder}/Dockerfile" do
  source 'Dockerfile.grafana'
end

cookbook_version = run_context.cookbook_collection[cookbook_name].metadata.version

docker_image image_name do
  source image_build_folder
  tag cookbook_version
  nocache true
  action :build_if_missing
end

docker_container 'grafana' do
  repo image_name
  tag cookbook_version
  port '80:3000'
  binds [
    '/var/grafana:/var/lib/grafana',
    '/var/log/grafana:/var/log/grafana'
  ]
  env [
    'GF_AUTH_ANONYMOUS_ENABLED=true',
    'GF_AUTH_ANONYMOUS_ORG_ROLE=Editor'
  ]
  links ['graphite-statsd']
  restart_policy 'always'
end
