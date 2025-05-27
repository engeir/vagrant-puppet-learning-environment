# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Ensure the puppet directory exists
  puppet_dir = File.expand_path("./puppet", __dir__)
  unless Dir.exist?(puppet_dir)
    puts "Creating puppet directory: #{puppet_dir}"
    Dir.mkdir(puppet_dir)
  end

  config.vm.provider("virtualbox") do |vb|
  end

  # Shell script for VirtualBox Guest Additions
  $guest_additions_script = <<-SHELL
#!/bin/bash
# Update kernel and install necessary packages
yum update -y
yum install -y kernel-devel-$(uname -r) kernel-headers-$(uname -r) gcc make perl dkms bzip2

echo "Installed kernel-devel and build tools. Vagrant will attempt to rebuild guest additions if needed."
SHELL

  config.vm.define(:puppetserver) do |puppetserver|
    puppetserver.vm.box = "centos/7"
    puppetserver.vm.hostname = "puppet.example.com"
    puppetserver.vm.provider(:libvirt) do |lv|
      lv.memory = 3072
      lv.cpus = 2
    end
    puppetserver.vm.provision "shell", inline: $guest_additions_script
    puppetserver.vm.provision("ansible") do |a|
      a.playbook = "install-puppet.yml"
      a.inventory_path = "hosts.ini"
    end
  end

  config.vm.define(:puppetagent0_1) do |puppetagent|
    puppetagent.vm.box = "centos/7"
    puppetagent.vm.hostname = "puppetagent01.example.com"
    puppetagent.vm.provider(:libvirt) do |lv|
      lv.memory = 1024
      lv.cpus = 2
    end
    puppetagent.vm.provision "shell", inline: $guest_additions_script
    puppetagent.vm.provision("ansible") do |a|
      a.playbook = "install-puppet.yml"
      a.inventory_path = "hosts.ini"
    end
  end

  config.vm.define(:puppetagent0_2) do |puppetagent|
    puppetagent.vm.box = "centos/7"
    puppetagent.vm.hostname = "puppetagent02.example.com"
    puppetagent.vm.provider(:libvirt) do |lv|
      lv.memory = 1024
      lv.cpus = 2
    end
    puppetagent.vm.provision "shell", inline: $guest_additions_script
    puppetagent.vm.provision("ansible") do |a|
      a.playbook = "install-puppet.yml"
      a.inventory_path = "hosts.ini"
    end
  end

  # Global Ansible provisioner - remove if Ansible is defined per VM
  # config.vm.provision("ansible") do |a|
  #   a.playbook = "install-puppet.yml"
  #   a.inventory_path = "hosts.ini"
  # end

  config.vm.synced_folder("./puppet", "/etc/puppetlabs/code/environments/production")
end
