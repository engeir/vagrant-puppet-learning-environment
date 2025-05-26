#!/bin/bash

yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
yum install -y puppet

# define DNS alternative names with the FQDN to the master server
echo "
[main]
server = puppet
environment = production
runinterval = 1h" >>/etc/puppetlabs/puppet/puppet.conf

# Register puppet client to puppetserver
puppet agent -t

# enable and start puppet agent
systemctl enable --now puppet
