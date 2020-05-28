#!/bin/bash
/usr/local/bin/start_nagios &
echo waiting 60 for nagios to start
sleep 60
KUBE_NAME=$(echo ${KUBERNETES_PORT_443_TCP_ADDR} | tr '.' '-')
sed -i -e "s/xxxxxx:6443/${KUBERNETES_PORT_443_TCP_ADDR}/g" /opt/nagios-api/kubeconfig
sed -i -e "s/yyyyyy:6443/${KUBE_NAME}/g" /opt/nagios-api/kubeconfig
/opt/env/bin/python /opt/nagios-api/nagios-api -p 8080 -s /opt/nagios/var/status.dat -c /opt/nagios/var/rw/nagios.cmd -l /opt/nagios/var/nagios.log &
echo waiting 60 for api to start
sleep 60
pushd /opt/nagios-api/ansible
ansible-playbook -i /opt/nagios-api/ansible/inventory /opt/nagios-api/ansible/nagios-reconfigure.yml
popd
fg
