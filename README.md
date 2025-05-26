# vagrant-puppet-learning-environment

This is my Vagrant config to learn Puppet 5 in a small lab environment. It consists of
one Puppet Server and two Puppet agents hosted on a ~~Ubuntu 20.04 LTS~~ CentOS 7.

## Config

Bash bootstrap scripts installs and configures the VMs with latest available
Puppetserver and agents.

## Usage

To use this environment you need to install Vagrant, I have chosen LibVirt as my
virtualization engine on a Ubuntu 18.04.

```bash
sudo apt install vagrant git
```

On RHEL9, this should do it

```bash
sudo dnf install libvirt libvirt-devel
vagrant plugin install vagrant-libvirt
```

### Create a Vagrant workdir

```bash
mkdir -p vagrant/puppet
cd vagrant/puppet || exit
```

### Clone my repo

```bash
git clone https://github.com/thornbux/vagrant-puppet-learning-environment.git
```

### Start up the engines

#### To build the test lab

We are adding a CentOS 7 VM as our desired OS and starting it up.

```bash
mkdir examples puppet
vagrant box add centos/7
vagrant up
```

#### List available VMs

```console
$ vagrant status
Current machine states:

puppetserver              running (libvirt)
puppetagent01            running (libvirt)
puppetagent02            running (libvirt)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

#### SSH into a VM

```bash
vagrant ssh puppetserver
```

You can ping your neighbour from inside the VM. Hostnames is defined in the Vagrant
file.

#### Destroy the lab

```bash
vagrant destroy
```

#### Reprovision lab

```bash
vagrant provision
```

#### Clean single VM and provision

```bash
vagrant destroy puppetagent01
```

If you destroy a Puppet agent node, remember to delete the Puppet SSH certificate on the
Puppet Server before you provision it again

```bash
puppet cert clean puppetagent02.example.com
```

It is now time to provision a new and fresh agent node

```bash
vagrant up puppetagent01
```

## Puppet preparation (Puppetserver)

SSH into the puppetserver

```bash
vagrant ssh puppetserver
sudo -i
```

### List certificates

```console
$ puppet cert list
  "puppetagent01.example.com" (SHA256) DF:17:68:C4:C3:6F:7E:E6:EE:96:C3:AF:7D:8C:D8:60:F7:8C:6F:97:6B:6A:51:88:43:A1:6A:3F:80:91:80:89
  "puppetagent02.example.com" (SHA256) 29:ED:9F:A4:D4:CC:24:86:67:71:CB:94:F8:66:BA:A3:CC:55:BC:D8:0B:CD:17:20:8E:BD:51:CA:FF:43:58:F0
```

### Sign certificate(s)

There are no need to sign the Puppet agents certificates because we are auto-signing the
certificates with the `/etc/puppetlabs/puppet/autosign.conf` file.

Here are the commands needed to sign the certificates manually

```bash
puppet cert sign hostname
```

## Ready for action

Your Puppet learning environment is now configured and ready to be explored.
