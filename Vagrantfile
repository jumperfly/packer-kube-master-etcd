# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.box = "file://output-virtualbox-ovf/kube-master-etcd-virtualbox.box"
  config.vm.provision "shell", privileged: false, inline: "kubectl version --client"
end
