You can view graphite at the main url: http://prod-metrics00.nix.sys.7d, and the graphite view on port 8080 at that address.


It runs two docker containers - one for statsd/graphite, and the other for grafana. The stats files & grafana database are mounted from the main host, so the docker containers are just running code and can be killed/rebuilt at will.


Logs (access & error) are mounted on the host inside /var/log, under statsd, graphite, carbon, and grafana.


Check for running containers (and get the unique container-id) with: sudo docker ps

Jump onto a container to check processes: sudo docker exec -it {container-id} bash


There should be statsd, carbon, and graphite services running in the statsd/graphite container. It's a 3rd party image and quite popular, but doesn't do the 1 service per container you'd normally do with Docker so it's a bit busy.


If no stats are coming through (ie no graphs at http://prod-metrics00.nix.sys.7d are updating), it's easiest to just remove the statsd/graphite container and re-run chef to see if that restarts needed processes:


get the container id with: sudo docker ps --filter=name=graphite-statsd --format="{{.ID}}"

stop/remove the container: sudo docker stop {container-id} && sudo docker rm {container-id}

run chef to recreate/start it: sudo chef-client


The chef output should show it rebuilding the container and re-linking it to the grafana one. Hopefully it will work then. Otherwise dig into the log files and see if there's errors.  
