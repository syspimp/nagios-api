#!/bin/bash
/usr/local/bin/start_nagios &
/opt/env/bin/python /opt/nagios-api/nagios-api -p 8080 -s /opt/nagios/var/status.dat -c /opt/nagios/var/rw/nagios.cmd -l /opt/nagios/var/nagios.log &
