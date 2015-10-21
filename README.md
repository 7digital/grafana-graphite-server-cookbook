Grafana + Graphite Cookbook
===========================

Installs a statsd / graphite setup with Grafana as a frontend using public Docker images:
* Nathan Hopsoft's [graphite/statsd](https://hub.docker.com/r/hopsoft/graphite-statsd)
* Official [grafana](https://hub.docker.com/r/grafana/grafana)

The cookbuild builds wrapper Docker images locally on the machine to add configuration files, then runs them. It also mounts needed storage folders (for Grafana & whisper) on the host machine.

## Usage

```
$ bundle install
$ kitchen test
```

NB: Don't forget to bump the version number in `metadata.rb` after making changes!
