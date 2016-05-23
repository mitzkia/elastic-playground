FROM ubuntu:latest
MAINTAINER <andras.mitzki@balabit.com>

RUN apt update -qq
RUN apt install -y --no-install-recommends software-properties-common
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java

RUN apt update -qq
RUN apt install -y --no-install-recommends wget curl oracle-java8-installer tar vim

ENV ELASTICUSER=elasticsearch
RUN adduser --disabled-password --gecos '' ${ELASTICUSER}
RUN adduser ${ELASTICUSER} sudo
RUN echo "${ELASTICUSER}:secret" | chpasswd

ADD https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/5.0.0-alpha2/elasticsearch-5.0.0-alpha2.tar.gz elasticsearch-5.0.0-alpha2.tar.gz
RUN tar -xf elasticsearch-5.0.0-alpha2.tar.gz
RUN chown -R $ELASTICUSER:$ELASTICUSER elasticsearch-5.0.0-alpha2/
USER $ELASTICUSER

EXPOSE 9200 9300

ENV IP1=192.168.10.3
ENV CLUSTER=elastic5
ENV CONFIG_FILE=/elasticsearch-5.0.0-alpha2/config/elasticsearch.yml

RUN echo "cluster.name: '$CLUSTER'" | tee --append $CONFIG_FILE
RUN echo 'discovery.zen.minimum_master_nodes: 1' | tee --append $CONFIG_FILE
RUN echo "discovery.zen.ping.unicast.hosts: ['$IP1']" | tee --append $CONFIG_FILE
RUN echo 'http.cors.allow-origin: /.*/' | tee --append $CONFIG_FILE
RUN echo 'http.cors.enabled: true' | tee --append $CONFIG_FILE
RUN echo 'network.bind_host: 0.0.0.0' | tee --append $CONFIG_FILE
RUN echo 'network.host: 0.0.0.0' | tee --append $CONFIG_FILE
RUN echo "network.publish_host: '$IP1'" | tee --append $CONFIG_FILE
RUN echo 'node.data: true' | tee --append $CONFIG_FILE
RUN echo 'node.master: true' | tee --append $CONFIG_FILE
RUN echo "node.name: '$CLUSTER'" | tee --append $CONFIG_FILE
