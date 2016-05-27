FROM elasticsearch:5
MAINTAINER <andras.mitzki@balabit.com>

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends vim curl

RUN echo y | bin/elasticsearch-plugin install -v x-pack
