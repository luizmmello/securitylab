# Use the official Kali Linux image
FROM kalilinux/kali-rolling:latest

# Update package index and install necessary packages for Wazuh and Osquery
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
    gnupg2 \
    curl \
    wget \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

# Add Wazuh repository
RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - \
    && echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list

# Add Osquery repository (if not already available in Kali)
# Note: Kali might already have Osquery, check before proceeding
RUN echo "deb [arch=amd64] http://pkg.osquery.io/deb deb main" | tee /etc/apt/sources.list.d/osquery.list \
    && apt-get update

# Install Wazuh Agent and Osquery
RUN apt-get install -y wazuh-agent osquery

# Configure Wazuh Agent
# Assuming you have an ossec.conf prepared in your build context
COPY ossec.conf /var/ossec/etc/ossec.conf
RUN echo "WAZUH_MANAGER_IP=wazuh" >> /var/ossec/etc/local_internal_options.conf  # Use service name 'wazuh'

# Configure Osquery with BPF events
COPY osquery.conf /etc/osquery/osquery.conf
RUN echo " --enable_bpf_events" >> /etc/osquery/osquery.flags

# Start scripts for Wazuh Agent and Osquery
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports if necessary (e.g., for remote agent management)
EXPOSE 1514 1515

# Define the entrypoint
ENTRYPOINT ["/entrypoint.sh"]