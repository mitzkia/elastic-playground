## Short description of the project:

### The goal of the project
 * To easily test syslog-ng OSE developement versions with different Elasticsearch versions

### Required packages

 * docker:
    * Installation steps: https://docs.docker.com/engine/installation/linux/ubuntulinux/
    * Github: https://github.com/docker/docker
 * docker-compose:
    * Installation steps: https://docs.docker.com/compose/install/
    * Github: https://github.com/docker/compose

### How project works

#### Elasticsearch

 * Docker provide us official Elasticsearch images for the following latest versions:
    * 1.7
    * 2.3
    * 5.0 alpha
 * DockerHub: https://hub.docker.com/_/elasticsearch/
 * Under the elastic1, elastic2, elastic5 directories we rebuild this images with custom configurations and setup (with shield plugin)
 * Note: From Elasticsearch 5 there is new X-PACK extension which bundles security, alerting, monitoring, reporting, and graph capabilities into one easy-to-install package. Reference: https://www.elastic.co/guide/en/x-pack/v5.0.0-alpha2-docs/xpack-introduction.html

#### syslog-ng

 * BalaBit provide us syslog-ng builder image, where we can build syslog-ng from source
 * DockerHub: https://hub.docker.com/r/balabit/syslog-ng-dev/
 * Under the syslogng38-elastic1, syslogng38-elastic2, syslogng38-elastic5 directories we build and install syslog-ng from source and also install required Elasticsearch libraries with the proper version

### docker-compose.yml

 * In the docker-compose.yml file we create a separate network for our running images and linking images in a following pairs:
    * elastic1 - syslogng38-elastic1
    * elastic2 - syslogng38-elastic2
    * elastic5 - syslogng38-elastic5

### How to run

 * From the project root directory we can run the following scripts:
    * `./start-again.sh`
        * Removes existing docker containers (cleanup)
        * Rebuild all images
        * Run environment
    * `./test-elasticsearch.sh`
        * Send message to syslog-ng and check the result on Elasticsearch side
 * How to enter into already running docker container:
    * with docker-compose: `docker-compose exec -it [container-name] /bin/bash` , example: docker-compose exec -it  elastic2 /bin/bash
