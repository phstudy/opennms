## OpenNMS Dockerfile

This repository contains **Dockerfile** of [OpenNMS](http://www.opennms.org/) for [Docker](https://www.docker.io/)'s [automated build](https://registry.hub.docker.com/u/study/opennms/) published to the public [Docker Registry](https://index.docker.io/).


### Usage

  1. start a postgres instance

    `docker run --name some-postgres -e LC_ALL=C.UTF-8 -d postgres`

  2. start a opennms instance and link it to the postgres instance

    `docker run --name some-opennms --link some-postgres:postgres -p 8980:8980 -d 'study/opennms'`
