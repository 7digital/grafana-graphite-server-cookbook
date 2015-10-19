Grafana + Graphite Cookbook
===========================

Installs a statsd / graphite setup with Grafana as a frontend using public Docker images:
* Nathan Hopsoft's [graphite/statsd](https://hub.docker.com/r/hopsoft/graphite-statsd)
* Official [grafana](https://hub.docker.com/r/grafana/grafana)

Builds the wrapper images on the machine then runs them, so you don't need a Docker repository. Also mounts the storage folders (for Grafana & whisper) on the host machine.

NB: Don't forget to bump the version number in `metadata.rb` after making changes!

`bundle install` then `kitchen test`
