#!/bin/bash -x

prefix="micek"
directories="elastic1 elastic2 elastic5 syslogng38-elastic1 syslogng38-elastic2 syslogng38-elastic5"
echo 'set system variable, needed by elasticsearch 5, see URL: [https:/github.com/docker-library/elasticsearch/issues/98/]'
sudo sysctl -w vm.max_map_count=262144

for directory in $directories ; do
    docker build --no-cache=False -t $prefix/$directory $directory/
    ret=$?
    if [[ $ret -ne 0 ]] ; then
        echo Build: [$directory] Failes
        exit 1
    fi
done
