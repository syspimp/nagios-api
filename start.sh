#!/bin/bash
/usr/local/bin/start_nagios &
echo waiting 10 for nagios to start
sleep 10
/opt/nagios-api/reconfig-nagios.sh
$(sleep 10 && curl http://localhost:8080/restart_nagios ) &
/opt/env/bin/python /opt/nagios-api/nagios-api -p 8080 -s /opt/nagios/var/status.dat -c /opt/nagios/var/rw/nagios.cmd -l /opt/nagios/var/nagios.log
