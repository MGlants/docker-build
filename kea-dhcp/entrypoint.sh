#!/usr/bin/env sh

set -e -u

RUNPATH="/usr/local/var/run/kea"

if [ -e "${RUNPATH}/kea-dhcp4.kea-dhcp4.pid" ]; then
    rm -f "${RUNPATH}/kea-dhcp4.kea-dhcp4.pid"
fi
if [ -e "${RUNPATH}/kea-dhcp6.kea-dhcp6.pid" ]; then
    rm -f "${RUNPATH}/kea-dhcp6.kea-dhcp6.pid"
fi
if [ -e "${RUNPATH}/kea-ctrl-agent.kea-ctrl-agent.pid" ]; then
        rm -f "${RUNPATH}/kea-ctrl-agent.kea-ctrl-agent.pid"
fi

keactrl start -c /etc/kea/keactrl.conf
sleep 10
set +e +u
if [[ -e /tmp/kea-dhcp4-ctrl.sock ]] && [[ -e /tmp/kea-dhcp6-ctrl.sock ]];then
  python3 /usr/local/bin/kea-exporter /tmp/kea-dhcp4-ctrl.sock /tmp/kea-dhcp4-ctrl.sock
elif [[ -e /tmp/kea-dhcp4-ctrl.sock ]];then
  python3 /usr/local/bin/kea-exporter /tmp/kea-dhcp4-ctrl.sock
elif [[ -e /tmp/kea-dhcp6-ctrl.sock ]];then
  python3 /usr/local/bin/kea-exporter /tmp/kea-dhcp4-ctrl.sock
fi
tail -f /dev/null