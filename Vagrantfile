# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.box = "file://output-kube-master-etcd/package.box"
  config.vm.provision "shell", privileged: false, inline: "kubectl version --client"
end
