#!/bin/bash
pushd /opt/nagios-api/ansible
ansible-playbook -i /opt/nagios-api/ansible/inventory /opt/nagios-api/ansible/nagios-reconfigure.yml
popd
