docker_image 'grafana/grafana'

docker_container 'grafana' do
  repo 'grafana/grafana'
  port '80:3000'
  binds ['/var/grafana:/var/lib/grafana']
  links ['graphite-statsd']
  restart_policy 'always'
end
