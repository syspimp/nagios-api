#!/bin/bash
/usr/local/bin/start_nagios
/opt/env/bin/python /opt/nagios-api/nagios-api -p 8080 -s /opt/status.dat -c /opt/nagios.cmd -l /opt/nagios.log -q
