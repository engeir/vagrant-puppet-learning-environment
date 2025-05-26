#!/bin/bash
# Note
# This script is not idempotent, /etc/puppetlabs/puppet/puppet.conf will appended at every provision unless it is a clean provision.

# variables
PUPPETLABS="/etc/puppetlabs/"

# configure puppet and puppetserver
yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
yum install -y puppetserver puppetdb puppetdb-termini
yum install -y puppet

# extra packages
yum install -y git tree

# enable puppetserver
systemctl enable puppetserver

# reduce memory usage on puppetserver
sed -i -e 's/2g/1g/g' /etc/sysconfig/puppetserver

# define DNS alternative names with the FQDN to the master server
echo "dns_alt_names = puppet

[main]
certname = puppet.example.com 
server = puppet.example.com
environment = production
runinterval = 1h" >>/etc/puppetlabs/puppet/puppet.conf

# enable auto-sign of agents
touch /etc/puppetlabs/puppet/autosign.conf
echo "*.example.com" >"$PUPPETLABS/puppet/autosign.conf"

# start puppetserver
systemctl start puppetserver
