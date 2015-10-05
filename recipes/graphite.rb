docker_image 'hopsoft/graphite-statsd'

docker_container 'graphite' do
  repo 'hopsoft/graphite-statsd'
  port '8125:8125/udp'
  binds [
    '/var/whisper:/opt/graphite/storage/whisper',
    '/var/graphite-configs:/opt/graphite/conf'
  ]
  restart_policy 'always'
end
