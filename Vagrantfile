# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vbguest.auto_update = false
  config.vm.box = "geerlingguy/centos7"
  #config.vm.box = "aviture/centos7"
  config.vm.provision :shell, path: "scripts/bootstrap.sh"
  config.vm.network "forwarded_port", guest: 6080, host: 6080, auto_correct: true
  config.vm.network "forwarded_port", guest: 6083, host: 6083, auto_correct: true
  config.vm.network "forwarded_port", guest: 6182, host: 6182, auto_correct: true
  config.vm.network "forwarded_port", guest: 9080, host: 9080, auto_correct: true
  config.vm.network "forwarded_port", guest: 9443, host: 9443, auto_correct: true
  config.vm.network "forwarded_port", guest: 9448, host: 9448, auto_correct: true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
     #vb.gui = true
     #vb.memory = "8192"
     vb.memory = "6144"
     vb.cpus="4"
  end

end
