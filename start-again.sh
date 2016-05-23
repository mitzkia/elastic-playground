#!/bin/bash -x

docker-compose stop
docker-compose rm -f -a

docker rm -f $(docker ps -aq)
./build-images.sh

docker-compose up -d
docker-compose ps
