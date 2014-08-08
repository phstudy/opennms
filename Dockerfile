FROM ubuntu:14.04
MAINTAINER Study Hsueh <ph.study@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV OPENNMS_HOME /usr/share/opennms

RUN apt-get update -qq && apt-get install -qqy wget

RUN echo '# contents of /etc/apt/sources.list.d/opennms.list' > /etc/apt/sources.list.d/opennms.list \
	&& echo 'deb http://debian.opennms.org stable main' >> /etc/apt/sources.list.d/opennms.list \
	&& echo 'deb-src http://debian.opennms.org stable main' >> /etc/apt/sources.list.d/opennms.list

RUN wget -O - http://debian.opennms.org/OPENNMS-GPG-KEY | sudo apt-key add -

RUN apt-get update -qq && apt-get install -qqy opennms

RUN apt-get autoclean && rm -rf /var/lib/apt/*

ADD ./docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8980/tcp

CMD ["/bin/bash", "-c", "$OPENNMS_HOME/bin/opennms start && tail -f /var/log/opennms/daemon/output.log"]
