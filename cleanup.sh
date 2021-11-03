# /!bin/bash

sudo rm -rf /srv/docker/grafana/data
sudo rm -rf /srv/docker/mongodb/data
sudo rm -rf /srv/docker/elastic/data

docker ps -qa | xargs docker rm $1 --force

echo "Everything is cleaned up"