#!/bin/bash

# Install apache utils
sudo apt-get update && sudo apt-get install apache2-utils -y

echo "Apache utils installed"

# Create volume folders 
sudo mkdir -p /srv/docker/grafana/data
sudo mkdir -p /srv/docker/mongodb/data
sudo mkdir -p /srv/docker/elastic/data

# Run services
docker-compose up --build -d
sudo chown -R 472:472 /srv/docker/grafana/data
sudo chown -R 472:472 /srv/docker/mongodb/data
sudo chown -R 1000:root /srv/docker/elastic/data

echo "Services spinned up. Waiting for startup"

# Wait for grafana to be up
sleep 10

# Upload dashboard and datasource
dashboard=$(<./grafana/dashboard.json)
curl -X POST http://admin:admin@localhost:3000/api/dashboards/db -H 'Accept: application/json' -H 'Content-Type: application/json' -d "{\"dashboard\":$dashboard}"

datasource=$(<./grafana/influxdb-datasource.json)
curl -X POST http://admin:admin@localhost:3000/api/datasources -H 'Accept: application/json' -H 'Content-Type: application/json' -d "$datasource"

echo "Datasource and dashboard set up"

# Run benchmark
ab -n 5000 -c 500 -g test.log http://localhost:80/api/users