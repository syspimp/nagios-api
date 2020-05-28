#FROM ubuntu:16.04
FROM jasonrivers/nagios:latest
MAINTAINER David Taylor <dataylor@redhat.com>

EXPOSE 80
EXPOSE 8080
# The following files can be mapped into the container for usages towards Nagios
# However setting these as a volume causes Docker to create directories for them
# VOLUME ["/opt/status.dat", "/opt/nagios.cmd", "/opt/nagios.log"]

RUN apt-get update && \
    apt-get install python-virtualenv libffi-dev python-dev python-pip python-setuptools openssl libssl-dev -y vim
RUN cd /opt && \
    virtualenv env && \
    /opt/env/bin/pip install diesel && \
    /opt/env/bin/pip install requests

RUN mkdir /opt/nagios-api
COPY . /opt/nagios-api

RUN echo "deb http://ppa.launchpad.net/vshn/icinga/ubuntu xenial main" >> /etc/apt/sources.list && \
    apt-get update && \
		apt-get install -y --allow-unauthenticated nagios-plugins-openshift
RUN mv -f /opt/nagios-api/oc /usr/bin/ && \
		mv -f /opt/nagios-api/nagios-plugins/check_openshift_node_new /usr/lib/nagios/plugins/check_openshift_node && \
		mv -f /opt/nagios-api/nagios-plugins/check_openshift_pod_status_count /usr/lib/nagios/plugins/ && \
		mv -f /opt/nagios-api/nagios-plugins/utils /usr/lib/nagios-plugins-openshift/utils && \
		mv -f /opt/nagios-api/objects/* /opt/nagios/etc/objects/ && \
		mv -f /opt/nagios-api/nagios.cfg /opt/nagios/etc/nagios.cfg


CMD [ "/opt/nagios-api/start.sh" ]
