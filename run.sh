#!/bin/bash

sudo mkdir -p /srv/docker/grafana/data
sudo mkdir -p /srv/docker/mongodb/data
sudo mkdir -p /srv/docker/elastic/data
docker-compose up --build -d
sudo chown -R 472:472 /srv/docker/grafana/data
sudo chown -R 472:472 /srv/docker/mongodb/data
sudo chown -R 472:472 /srv/docker/elastic/data

echo "Services spinned up. Waiting for startup"

sleep 10

datasource=$(cat ./grafana/influxdb-datasource.json)
curl -X POST http://admin:admin@localhost:3000/api/datasources \
 -H 'Accept: application/json' -H 'Content-Type: application/json' \
  -d "$datasource"

dashboard=$(cat ./grafana/dashboard.json)
curl -X POST http://admin:admin@localhost:3000/api/dashboards/db \
 -H 'Accept: application/json' -H 'Content-Type: application/json' \
  -d "{\"dashboard\":$dashboard"

echo "Datasource and dashboard set up"