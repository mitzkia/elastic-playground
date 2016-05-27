#!/bin/bash -x

elastic_nodes="192.168.20.1 192.168.20.2 192.168.20.3"

# test basic auth with curl
for elastic_node in $elastic_nodes; do
    sleep 1
    curl --user elastic:changeme -XGET http://$elastic_node:9200/_cluster/health?pretty=true
done
