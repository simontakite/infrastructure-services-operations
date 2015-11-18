#!/bin/bash

# Host file
echo "10.1.0.182 foreman-ub1404v.prd.oslo.edgelsoft.local foreman puppet" >> /etc/hosts

# Timezone
echo "Europe/Oslo" > /etc/timezone
dpkg-reconfigure --frontend=noninteractive tzdata

# Set norwegian locale
locale-gen nb_NB.UTF-8

# make swap
dd if=/dev/zero of=/swapfile bs=1G count=4 > /dev/null
chmod 0600 /swapfile
mkswap /swapfile > /dev/null
swapon /swapfile > /dev/null
echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab

# INSTALL LOGSTASH-FORWARDER
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elasticsearch.org/logstashforwarder/debian stable main" | sudo tee /etc/apt/sources.list.d/logstashforwarder.list
apt-get update
apt-get -y install logstash-forwarder
chmod +x /etc/init.d/logstash-forwarder
update-rc.d logstash-forwarder defaults

# Populate logstash-forwarder cert file
mkdir -p /etc/pki/tls/certs/
touch /etc/pki/tls/certs/logstash-forwarder.crt
cat > /etc/pki/tls/certs/logstash-forwarder.crt <<EOF
-----BEGIN CERTIFICATE-----
MIIDbjCCAlagAwIBAgIJAMmkbtpdhE3hMA0GCSqGSIb3DQEBCwUAMEUxCzAJBgNV
BAYTAkFVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVQQKDBhJbnRlcm5ldCBX
aWRnaXRzIFB0eSBMdGQwHhcNMTUxMTAxMTM0MjQ4WhcNMjUxMDI5MTM0MjQ4WjBF
MQswCQYDVQQGEwJBVTETMBEGA1UECAwKU29tZS1TdGF0ZTEhMB8GA1UECgwYSW50
ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAsxT0wQpEsm7qkzxQzS5sqLK6Kv+8uf9iAMqZ8upeUEOxTFF/5QzBL1lG
tWUaCs167m6o16JSgJ8b5TE/rcI1yZ/bSvDIzln/xef/bkDVthOuCQAnGBKnlyMh
e0WtHDTwrOpA9QwJofNlr/q0G33Khx7i6P4RE4CztCe1WZaeyB+Q5UDAD/V6m0P4
Sl351LsenjfR6z4b49mek69GIlRpt5SkzfyMgqRq/4lpg1N3RLSUf7e0R8gOlpDa
/TQhFP2SS4I82WIhepyLLTbAy3fRPOsmybLbilFCAVUpwQPHw/lbG3LLBg8kKwBQ
6eASlUNtWAmjcw2uusf2fWFLLrKiwQIDAQABo2EwXzAPBgNVHREECDAGhwQKAQHG
MB0GA1UdDgQWBBSSCQyQJecpSadw1pCpX3iwRI7CizAfBgNVHSMEGDAWgBSSCQyQ
JecpSadw1pCpX3iwRI7CizAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IB
AQAGKeD2aJ8I4Prfy7Z+KfNj3RkZEcmKekvvzXPfNM1ZHHTX+q9PuCkJRads14JG
+NAQgk7lx+qf+sfk3bRHPqyLYdSaPMKsMu74G7ly0pdSo9c5uOdn4dWbve7JKOjw
PoM4npHCsxdHqTgaoCqxzhyU5mGFiAaybPgosRDgutVwmDmgB18sHtmUuhcbT95z
+tSdrw8Uc3x/Zea8H8U6P/YkoSdMhFcvEhLI7vjWaAECGUIoK6udwJE6I0pu0IQ6
kZtyCJGL9mP6kLvzfWmj5ICOXgc9yqQ+bUfVYfnSJkY4yRtbOjhdrb3siVgK39kR
+OoVZPFTnCHCW+ug/tTwKAts
-----END CERTIFICATE-----
EOF

# Populate logstash-forwarder conf file
cat > /etc/logstash-forwarder.conf <<EOF
{
  # The network section covers network configuration :)
  "network": {
    "servers": [ "10.1.1.198:5043" ],
    "ssl ca": "/etc/pki/tls/certs/logstash-forwarder.crt",
    "timeout": 15
  },

  # The list of files configurations
  "files": [
    {
      "paths": [
        "/var/log/syslog",
        "/var/log/auth.log"
       ],
      "fields": { "type": "syslog" }
    }
  ]
}
EOF
#restart logstash-forwarder
/etc/init.d/logstash-forwarder restart

# INSTALL ZABBIX
apt-get update
apt-get -y install zabbix-agent

cat > /etc/zabbix/zabbix_agent.conf <<EOF
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix-agent/zabbix_agentd.log
LogFileSize=0
DebugLevel=5
Server=10.1.1.134
ListenPort=10050
Include=/etc/zabbix/zabbix_agentd.conf.d/
EOF

cat > /etc/zabbix/zabbix_agentd.conf<<EOF
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix-agent/zabbix_agentd.log
LogFileSize=0
Server=10.1.1.134
#ServerActive=127.0.0.1
#Hostname=Zabbix server
Include=/etc/zabbix/zabbix_agentd.conf.d/
EOF

# Restart zabbix
service zabbix-agent restart


# CONFIGURE NFS
apt-get -y install rpcbind nfs-common
cat > /etc/hosts.deny <<EOF
rpcbind : ALL
EOF
cat > /etc/hosts.allow <<EOF
rpcbind : 10.1.1.199
EOF
mkdir -p /mnt/data
mount 10.1.1.199:/mnt/servers /mnt/data
echo "mount 10.1.1.199:/mnt/servers /mnt/data nfs rw,hard,intr 0 0" >> /etc/fstab

# INSTALL PUPPET AGENT
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update
apt-get -y install puppet

cat > /etc/default/puppet <<EOF
# Defaults for puppet - sourced by /etc/init.d/puppet

# Enable puppet agent service?
# Setting this to "yes" allows the puppet agent service to run.
# Setting this to "no" keeps the puppet agent service from running.
START=yes

# Startup options
DAEMON_OPTS=""
EOF

# Local puppet version
cat > /etc/apt/preferences.d/00-puppet.pref<<EOF
Package: puppet puppet-common
Pin: version 3.8*
Pin-Priority: 501
EOF

cat > /etc/puppet/puppet.conf<<EOF
[main]
logdir=/var/log/puppet
server=foreman-ub1404v.prd.oslo.edgelsoft.local
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$vardir/lib/facter

[master]
# These are needed when the puppetmaster is run by passenger
# and can safely be removed if webrick is used.
ssl_client_header = SSL_CLIENT_S_DN 
ssl_client_verify_header = SSL_CLIENT_VERIFY
EOF


# Restart puppet 
service puppet restart

puppet agent --enable
puppet agent --test 
