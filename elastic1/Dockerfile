FROM elasticsearch:1
MAINTAINER <andras.mitzki@balabit.com>

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends vim curl

RUN bin/plugin -install elasticsearch/license/latest
RUN bin/plugin -install elasticsearch/shield/latest

RUN bin/shield/esusers useradd elastic -r admin -p changeme
