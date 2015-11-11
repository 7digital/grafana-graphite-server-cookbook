grafana_version = '2.1.3'

docker_image 'grafana/grafana' do
  tag grafana_version
end

docker_container 'grafana' do
  repo 'grafana/grafana'
  tag grafana_version
  port '80:3000'
  binds [
    '/var/grafana:/var/lib/grafana',
    '/var/log/grafana:/var/log/grafana'
  ]
  links ['graphite-statsd']
  restart_policy 'always'
end
