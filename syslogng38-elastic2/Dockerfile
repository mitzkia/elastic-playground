FROM balabit/syslog-ng-dev:latest
MAINTAINER <andras.mitzki@balabit.com>

RUN apt-get update -qq
RUN git clone -b f/elasticsearch-v2-mode-http https://github.com/lbudai/syslog-ng.git /src/syslog-ng
RUN pip install -r /src/syslog-ng/requirements.txt
WORKDIR /src/syslog-ng/
RUN ./autogen.sh
RUN mkdir -p /src/syslog-ng/build
WORKDIR /src/syslog-ng/build
RUN ../configure --enable-debug --prefix=/install/syslog-ng && make && make install

ADD syslog-ng.conf /install/syslog-ng/syslog-ng.conf
ADD elastic-resource.yml /install/syslog-ng/elastic-resource.yml

ADD https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.3/elasticsearch-2.3.3.deb elasticsearch-2.3.3.deb
RUN dpkg -i elasticsearch-2.3.3.deb

EXPOSE 5555
