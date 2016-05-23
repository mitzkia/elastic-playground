#!/bin/bash -x

prefix="micek"
directories="elastic1 elastic2 elastic5 syslogng38-elastic1 syslogng38-elastic2 syslogng38-elastic5"

for directory in $directories ; do
    docker build --no-cache=False -t $prefix/$directory $directory/
    ret=$?
    if [[ $ret -ne 0 ]] ; then
        echo Build: [$directory] Failes
        exit 1
    fi
done
