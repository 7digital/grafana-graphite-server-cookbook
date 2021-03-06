Grafana + Graphite Cookbook
===========================

[![Build Status](https://travis-ci.org/7digital/grafana-graphite-server-cookbook.svg?branch=master)](https://travis-ci.org/7digital/grafana-graphite-server-cookbook)

Installs a statsd / graphite setup with Grafana as a frontend, using public Docker images:
* Nathan Hopsoft's [graphite/statsd](https://hub.docker.com/r/hopsoft/graphite-statsd)
* Official [grafana](https://hub.docker.com/r/grafana/grafana)

The cookbuild builds wrapper Docker images locally on the machine to add configuration files, then runs them. It also mounts needed storage folders (for Grafana's database & graphite's whisper storage files) on the host machine, so they survive across container upgrades.

### Usage

```
$ bundle install

# Run integration tests & linting:
$ rake all

# (optional) Run tests & keep the box up to have a play:
$ kitchen test --destroy=never
```

Be sure to update cookbook dependencies now and then: `berks update`

If you ran `kitchen test --destroy=never`, you can try the UI with:
* Browse to [http://localhost:8080](http://localhost:8080) (default user/pass: admin)
* Add `http://graphite-statsd` as a datasource in Grafana
* Send sample stats to test (`<CTL-Z>` to sleep/stop):
  * `while true; do echo -n "test:$(((RANDOM % 10) + 1))|c" | nc -w 1 -u localhost 8125; done`

NB: Don't forget to bump the version number in `metadata.rb` after making changes!

### Debugging

You can log into running Docker containers via (pick your container):

`sudo docker exec -it {graphite-statsd|grafana} bash`
