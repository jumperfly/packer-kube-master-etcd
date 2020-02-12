#!/bin/bash

## Script to run a test build locally - parses Jenkinsfile for latest configuration
eval $(egrep 'BASE_BOX_VERSION =|KUBE_MAJOR_MINOR =|KUBE_PATCH =' Jenkinsfile | awk '{ print "export " $1 $2 $3 }')
BOX_ADD_CMD=$(grep 'box add' Jenkinsfile | sed 's/.*sh "\([^"]\+\)"/\1/')
if [ ! -f $HOME/.vagrant.d/boxes/jumperfly-VAGRANTSLASH-centos-7/$BASE_BOX_VERSION/virtualbox/box.ovf ]; then
  $BOX_ADD_CMD
fi
rm -rf roles output-*
packer build -except=vagrant-cloud packer.json
