FROM elasticsearch:latest
MAINTAINER <andras.mitzki@balabit.com>

ENV SHIELD_USER=elasticsearch
ENV HOSTNAME=localhost
ENV PASSWORD=qqq123
ENV IP1=192.168.10.2
ENV IP2=192.168.10.12
ENV CLUSTER=elastic2
ENV CONFIG_FILE=/etc/elasticsearch/elasticsearch.yml

RUN apt update -qq
RUN apt install -y --no-install-recommends wget curl tar vim

RUN /usr/share/elasticsearch/bin/plugin install license
RUN /usr/share/elasticsearch/bin/plugin install shield

RUN mkdir -p /ssl-keys
WORKDIR /ssl-keys
# generate pub-priv keypair
RUN openssl genrsa -out rootCA.key 2048
# generate a self-signed CA certificate
RUN openssl req -x509 -new -nodes -key rootCA.key -days 365 -out rootCA.crt -subj '/C=HU/ST=test/L=test/O=test/CN=$HOSTNAME'
# creates a private key and certificate that the node will use to identify itself
RUN keytool -genkey -keystore server.jks -keyalg RSA -keysize 2048 -validity 712 -ext san=dns:$HOSTNAME,ip:$IP1,ip:$IP2 -keypass $PASSWORD -storepass $PASSWORD -dname 'CN=$HOSTNAME, OU=test, O=test, L=test, S=test, C=test' -v
# import the CA certificate into the Java Keystore Database
RUN keytool -importcert -keystore server.jks -file rootCA.crt -keypass $PASSWORD -storepass $PASSWORD -noprompt -v -alias $CLUSTER
# Create a certificate signing request
RUN keytool -certreq -keystore server.jks -file server.csr -keyalg RSA -ext san=dns:$HOSTNAME,ip:$IP1,ip:$IP2 -keypass $PASSWORD -storepass $PASSWORD -dname 'CN=$HOSTNAME, OU=test, O=test, L=test, S=test, C=test' -v
# Generate a signed certificate with the csr
RUN openssl x509 -req -days 730 -in server.csr -CA rootCA.crt -CAkey rootCA.key -set_serial 01 -out server-signed.crt
# import the generated signed-certificate to the Java Keystore Database
RUN keytool -importcert -keystore server.jks -file server-signed.crt -keypass $PASSWORD -storepass $PASSWORD -noprompt -v -alias $CLUSTER-signed
# copy cert files next to the elasticsearch configuration
RUN cp * /etc/elasticsearch/

RUN echo "cluster.name: '$CLUSTER'" | tee --append $CONFIG_FILE
RUN echo 'discovery.zen.ping.multicast.enabled: false' | tee --append $CONFIG_FILE
RUN echo 'http.cors.allow-origin: /.*/' | tee --append $CONFIG_FILE
RUN echo 'http.cors.enabled: true' | tee --append $CONFIG_FILE
RUN echo 'network.bind_host: 0.0.0.0' | tee --append $CONFIG_FILE
RUN echo 'network.host: 0.0.0.0' | tee --append $CONFIG_FILE
RUN echo 'node.data: true' | tee --append $CONFIG_FILE
RUN echo 'node.master: true' | tee --append $CONFIG_FILE
RUN echo "node.name: '$CLUSTER'" | tee --append $CONFIG_FILE
RUN echo 'shield.audit.enabled: true' | tee --append $CONFIG_FILE
RUN echo 'shield.http.ssl: true' | tee --append $CONFIG_FILE
RUN echo 'shield.ssl.keystore.path: /etc/elasticsearch/server.jks' | tee --append $CONFIG_FILE
RUN echo 'shield.transport.ssl: true' | tee --append $CONFIG_FILE
RUN echo "discovery.zen.ping.unicast.hosts: ['$IP1']" | tee --append $CONFIG_FILE
RUN echo "network.publish_host: '$IP1'" | tee --append $CONFIG_FILE
RUN echo "shield.ssl.keystore.password: '$PASSWORD'" | tee --append $CONFIG_FILE

RUN /usr/share/elasticsearch/bin/shield/esusers useradd $SHIELD_USER -p $PASSWORD -r admin
RUN chown -R elasticsearch:elasticsearch /etc/elasticsearch/
