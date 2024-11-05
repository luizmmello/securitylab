#!/bin/bash
set -e

# Start Wazuh agent
/var/ossec/bin/wazuh-control start

# Start Osquery with BPF
osqueryd --config_path=/etc/osquery/osquery.conf --flagfile=/etc/osquery/osquery.flags --verbose

# Start services common to Metasploitable2
service ssh start
service apache2 start
service proftpd start

# Keep container running
tail -f /dev/null