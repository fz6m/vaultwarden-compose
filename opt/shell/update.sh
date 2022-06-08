#!/bin/bash

cd /opt/docker
docker-compose stop

docker-compose rm
docker rmi axizdkr/tengine
docker rmi vaultwarden/server:latest

docker-compose pull
docker-compose up -d
