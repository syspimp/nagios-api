#FROM ubuntu:16.04
FROM jasonrivers/nagios:latest
MAINTAINER David Taylor <dataylor@redhat.com>

EXPOSE 80
EXPOSE 8080
# The following files can be mapped into the container for usages towards Nagios
# However setting these as a volume causes Docker to create directories for them
# VOLUME ["/opt/status.dat", "/opt/nagios.cmd", "/opt/nagios.log"]

RUN apt-get update && \
    apt-get install python-virtualenv libffi-dev python-dev python-pip python-setuptools openssl libssl-dev -y
RUN cd /opt && \
    virtualenv env && \
    /opt/env/bin/pip install diesel && \
    /opt/env/bin/pip install requests

RUN mkdir /opt/nagios-api
COPY . /opt/nagios-api

RUN echo "deb http://ppa.launchpad.net/vshn/icinga/ubuntu xenial main" >> /etc/apt/sources.list && \
    apt-get update && \
		apt-get install -y --allow-unauthenticated nagios-plugins-openshift
CMD [ "/opt/nagios-api/start.sh" ]
