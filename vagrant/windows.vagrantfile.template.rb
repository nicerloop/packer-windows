# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.6.2"

Vagrant.configure("2") do |config|
  config.vm.communicator = "winssh"
  config.vm.guest = :windows

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--cpus", 2]
    v.customize ["modifyvm", :id, "--memory", 4096]
    v.customize ["modifyvm", :id, "--vram", 128]
  end
end
