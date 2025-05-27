# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Ensure the puppet directory exists
  puppet_dir = File.expand_path("./puppet", __dir__)
  unless Dir.exist?(puppet_dir)
    puts("Creating puppet directory: #{puppet_dir}")
    Dir.mkdir(puppet_dir)
  end

  config.vm.provider("virtualbox") do |vb|
  end

  # Configure vagrant-vbguest plugin
  config.vbguest.auto_update = true
  config.vbguest.iso_path = "http://download.virtualbox.org/virtualbox/%{version}/VBoxGuestAdditions_%{version}.iso"

  config.vm.define(:puppetserver) do |puppetserver|
    puppetserver.vm.box = "ubuntu/focal64"
    puppetserver.vm.hostname = "puppet.example.com"
    # Assign a static IP
    puppetserver.vm.network("private_network", ip: "192.168.56.10")
    puppetserver.vm.provider(:virtualbox) do |lv|
      lv.memory = 3072
      lv.cpus = 2
    end

    puppetserver.vm.provision("ansible") do |a|
      a.playbook = "install-puppet.yml"
      a.inventory_path = "hosts.ini"
      a.groups = "puppet_servers"
      # a.install = true
      # a.install_mode = "default"
    end
  end

  config.vm.define(:puppetagent0_1) do |puppetagent|
    puppetagent.vm.box = "ubuntu/focal64"
    puppetagent.vm.hostname = "puppetagent01.example.com"
    # Assign a static IP
    puppetagent.vm.network("private_network", ip: "192.168.56.11")
    puppetagent.vm.provider(:virtualbox) do |lv|
      lv.memory = 1024
      lv.cpus = 2
    end

    puppetagent.vm.provision("ansible") do |a|
      a.playbook = "install-puppet.yml"
      a.inventory_path = "hosts.ini"
      a.groups = "puppet_agents"
      # a.install = true
      # a.install_mode = "default"
    end
  end

  config.vm.define(:puppetagent0_2) do |puppetagent|
    puppetagent.vm.box = "ubuntu/focal64"
    puppetagent.vm.hostname = "puppetagent02.example.com"
    # Assign a static IP
    puppetagent.vm.network("private_network", ip: "192.168.56.12")
    puppetagent.vm.provider(:virtualbox) do |lv|
      lv.memory = 1024
      lv.cpus = 2
    end

    puppetagent.vm.provision("ansible") do |a|
      a.playbook = "install-puppet.yml"
      a.inventory_path = "hosts.ini"
      a.groups = "puppet_agents"
      # a.install = true
      # a.install_mode = "default"
    end
  end

  # Global Ansible provisioner - remove if Ansible is defined per VM
  # config.vm.provision("ansible") do |a|
  #   a.playbook = "install-puppet.yml"
  #   a.inventory_path = "hosts.ini"
  # end

  config.vm.synced_folder("./puppet", "/etc/puppetlabs/code/environments/production")
end
