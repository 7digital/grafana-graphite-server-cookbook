docker_image 'hopsoft/graphite-statsd'

docker_container 'graphite' do
  repo 'hopsoft/graphite-statsd'
end
