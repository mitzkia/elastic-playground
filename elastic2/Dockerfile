FROM elasticsearch:2
MAINTAINER <andras.mitzki@balabit.com>

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends vim curl

RUN /usr/share/elasticsearch/bin/plugin install license
RUN /usr/share/elasticsearch/bin/plugin install shield

RUN bin/shield/esusers useradd elastic -r admin -p changeme
