# /!bin/bash

sudo rm -rf /srv/docker/grafana/data
sudo rm -rf /srv/docker/mongodb/data
sudo rm -rf /srv/docker/elastic/data

docker-compose down

echo "Everything is cleaned up"