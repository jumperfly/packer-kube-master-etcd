pipeline {
    agent any

    options {
        ansiColor('xterm')
    }

    environment {
        VAGRANT_CLOUD_TOKEN = credentials('vagrant-cloud')
        BASE_BOX_VERSION = "15.11"
        KUBE_MAJOR_MINOR = "1.13"
        KUBE_PATCH = "1"
    }

    stages {
        stage('Clean') {
            when {
                anyOf {
                    expression { return fileExists("output-virtualbox-ovf") }
                    expression { return fileExists("roles") }
                }
            }
            steps {
                sh 'rm -rf roles output-*'
            }
        }
        stage ('Download Base Box') {
            when {
                expression { return !fileExists("$HOME/.vagrant.d/boxes/jumperfly-VAGRANTSLASH-etcd-base-3.3/$BASE_BOX_VERSION/virtualbox/box.ovf") }
            }
            steps {
                sh "vagrant box add jumperfly/etcd-base-3.3 --box-version $BASE_BOX_VERSION"
            }
        }
        stage('Build Base') {
            steps {
                sh 'packer build kube-master-etcd-base.json'
            }
        }
        stage ('Download Box') {
            when {
                expression { return !fileExists("$HOME/.vagrant.d/boxes/jumperfly-VAGRANTSLASH-etcd-3.3/$BASE_BOX_VERSION/virtualbox/box.ovf") }
            }
            steps {
                sh "vagrant box add jumperfly/etcd-3.3 --box-version $BASE_BOX_VERSION"
            }
        }
        stage('Build') {
            steps {
                sh 'packer build kube-master-etcd.json'
            }
        }
    }
}
