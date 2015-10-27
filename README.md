Grafana + Graphite Cookbook
===========================

Installs a statsd / graphite setup with Grafana as a frontend using public Docker images:
* Nathan Hopsoft's [graphite/statsd](https://hub.docker.com/r/hopsoft/graphite-statsd)
* Official [grafana](https://hub.docker.com/r/grafana/grafana)

The cookbuild builds wrapper Docker images locally on the machine to add configuration files, then runs them. It also mounts needed storage folders (for Grafana & whisper) on the host machine.

### Usage

```
$ bundle install
$ kitchen test --destroy=never
```

* Browse to [http://localhost:8080](http://localhost:8080) (default user/pass: admin)
* Add `http://graphite-statsd` as a datasource in Grafana
* Send sample stats to test (`<CTL-Z>` to sleep/stop):
  * `while true; do echo -n "test:$(((RANDOM % 10) + 1))|c" | nc -w 1 -u localhost 8125; done`

NB: Don't forget to bump the version number in `metadata.rb` after making changes!

### TODO

[x] Ensure grafana dashboards are getting stored outside the container (stored in the mounted `/var/grafana/grafana.db` sqlite db file)
[ ] Tweak config files for statsd & graphite
[ ] Cron job to auto delete unused whisper files
[ ]  Run Docker 1.8 (ServerSpec needs patched to support changes in `docker inspect` for this to work)
