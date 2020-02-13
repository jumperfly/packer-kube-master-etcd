#!/bin/bash

## Script to run a test build locally - parses Jenkinsfile for latest configuration
eval $(egrep 'BASE_BOX_VERSION =|KUBE_MAJOR_MINOR =|KUBE_PATCH =' Jenkinsfile | awk '{ print "export " $1 $2 $3 }')
BASE_BOX_ADD_CMD=$(grep 'box add' Jenkinsfile | grep base | sed 's/.*sh "\([^"]\+\)"/\1/' | envsubst)
BOX_ADD_CMD=$(grep 'box add' Jenkinsfile | grep -v base | sed 's/.*sh "\([^"]\+\)"/\1/' | envsubst)
if [ ! -f $HOME/.vagrant.d/boxes/jumperfly-VAGRANTSLASH-etcd-3.3/$BASE_BOX_VERSION/virtualbox/box.ovf ]; then
  $BOX_ADD_CMD
fi
if [ ! -f $HOME/.vagrant.d/boxes/jumperfly-VAGRANTSLASH-etcd-base-3.3/$BASE_BOX_VERSION/virtualbox/box.ovf ]; then
  $BASE_BOX_ADD_CMD
fi
rm -rf roles output-*
packer build -except=vagrant-cloud kube-master-etcd-base.json
packer build -except=vagrant-cloud kube-master-etcd.json
