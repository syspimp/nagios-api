#!/bin/bash
/opt/nagios-api/reconfig-nagios.sh
/usr/local/bin/start_nagios &
echo waiting 10 for nagios to start
sleep 10
/opt/env/bin/python /opt/nagios-api/nagios-api -p 8080 -s /opt/nagios/var/status.dat -c /opt/nagios/var/rw/nagios.cmd -l /opt/nagios/var/nagios.log
