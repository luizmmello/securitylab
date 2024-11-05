#!/bin/bash
set -e

# Start Wazuh agent
/var/ossec/bin/wazuh-control start

# Start Osquery with BPF
osqueryd --config_path=/etc/osquery/osquery.conf --flagfile=/etc/osquery/osquery.flags --verbose

# DVWA service is already started in the base image, but if not:
# /usr/sbin/apachectl start

# Keep container running
tail -f /dev/null