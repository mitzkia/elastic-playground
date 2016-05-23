FROM elasticsearch:1.7
MAINTAINER <andras.mitzki@balabit.com>

ENV IP1=192.168.10.1
ENV CLUSTER=elastic1
ENV CONFIG_FILE=/etc/elasticsearch/elasticsearch.yml

RUN apt update -qq
RUN apt install -y --no-install-recommends wget curl tar vim

RUN echo "cluster.name: '$CLUSTER'" | tee --append $CONFIG_FILE
RUN echo 'discovery.zen.ping.multicast.enabled: false' | tee --append $CONFIG_FILE
RUN echo "discovery.zen.ping.unicast.hosts: ['$IP1']" | tee --append $CONFIG_FILE
RUN echo 'http.cors.allow-origin: /.*/' | tee --append $CONFIG_FILE
RUN echo 'http.cors.enabled: true' | tee --append $CONFIG_FILE
RUN echo 'network.bind_host: 0.0.0.0' | tee --append $CONFIG_FILE
RUN echo 'network.host: 0.0.0.0' | tee --append $CONFIG_FILE
RUN echo "network.publish_host: '$IP1'" | tee --append $CONFIG_FILE
RUN echo 'node.data: true' | tee --append $CONFIG_FILE
RUN echo 'node.master: true' | tee --append $CONFIG_FILE
RUN echo "node.name: '$CLUSTER'" | tee --append $CONFIG_FILE

RUN chown -R elasticsearch:elasticsearch /etc/elasticsearch/
