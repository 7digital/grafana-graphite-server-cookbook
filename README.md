Grafana + Graphite Cookbook
===========================

Installs a statsd / graphite setup with Grafana as a frontend using public Docker images:
* Nathan Hopsoft's [graphite/statsd](https://hub.docker.com/r/hopsoft/graphite-statsd)
* Official [grafana](https://hub.docker.com/r/grafana/grafana)

The cookbuild builds wrapper Docker images locally on the machine to add configuration files, then runs them. It also mounts needed storage folders (for Grafana & whisper) on the host machine.

## Usage

```
$ bundle install
$ kitchen test --destroy=never
$ curl localhost:8080
```

NB: Don't forget to bump the version number in `metadata.rb` after making changes!

## TODO

* Ensure grafana dashboards are getting stored outside the container
* Tweak config files for statsd & graphite
* Cron job to auto delete unused whisper files
* Run Docker 1.8 (ServerSpec needs patched to support changes in `docker inspect` for this to work)
