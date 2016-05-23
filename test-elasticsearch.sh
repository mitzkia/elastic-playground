#!/bin/bash -x

elastic_nodes="192.168.10.1 192.168.10.2 192.168.10.3"

for elastic_node in $elastic_nodes; do
    curl -XGET http://$elastic_node:9200/_cluster/health?pretty=true
done
