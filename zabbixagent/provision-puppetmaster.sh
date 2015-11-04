#!/bin/bash

apt-get update

sed -i s'/127.0.0.1 localhost/127.0.0.1 puppetmaster-ub1404.edgesoft.local/'g /etc/hosts

# Fix hostnames
echo "puppetmaster-ub1404.edgesoft.local" > /etc/hostname
hostname puppetmaster-ub1404.edgesoft.local

# Set norwegian locale
locale-gen nb_NO.UTF-8

# Install puppetmaster 
cd ~; wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update

# Install puppetmaster-passenger
sudo apt-get install -q -y puppetmaster-passenger

# Stop apache
sudo service apache2 stop

# Lock puppet version

cat > /etc/apt/preferences.d/00-puppet.pref << 'EOF'
Package: puppet puppet-common puppetmaster-passenger
Pin: version 3.8*
Pin-Priority: 501
EOF

# Set Up Names and Certificates
# Delete Existing Certificates
#sudo rm -rf /var/lib/puppet/ssl

# Configure Certificate
cat > /etc/puppet/puppet.conf << 'EOF'
[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$vardir/lib/facter
certname=puppetmaster-ub1404.edgesoft.local
dns_alt_names=puppet, puppetmaster-ub1404.edgesoft.local

[master]
# These are needed when the puppetmaster is run by passenger
# and can safely be removed if webrick is used.
ssl_client_header = SSL_CLIENT_S_DN
ssl_client_verify_header = SSL_CLIENT_VERIFY
EOF

# Enable the foreman repo
echo "deb http://deb.theforeman.org/ trusty 1.9" > /etc/apt/sources.list.d/foreman.list
echo "deb http://deb.theforeman.org/ plugins 1.9" >> /etc/apt/sources.list.d/foreman.list
wget -q http://deb.theforeman.org/pubkey.gpg -O- | apt-key add -

# Install the foreman installer
apt-get update && apt-get -y install foreman-installer

# Run the installer
foreman-installer