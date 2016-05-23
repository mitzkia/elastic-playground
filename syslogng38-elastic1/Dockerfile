FROM balabit/syslog-ng-dev:latest
MAINTAINER <andras.mitzki@balabit.com>

RUN apt update -qq
RUN git clone https://github.com/balabit/syslog-ng.git /src/syslog-ng
RUN pip install -r /src/syslog-ng/requirements.txt
WORKDIR /src/syslog-ng/
RUN ./autogen.sh
RUN mkdir -p /src/syslog-ng/build
WORKDIR /src/syslog-ng/build
RUN ../configure --enable-debug --prefix=/install/syslog-ng && make && make install

ADD syslog-ng.conf /install/syslog-ng/syslog-ng.conf
ADD elastic-resource.yml /install/syslog-ng/elastic-resource.yml

ADD https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.deb elasticsearch-1.7.5.deb
RUN dpkg -i elasticsearch-1.7.5.deb

EXPOSE 5555
