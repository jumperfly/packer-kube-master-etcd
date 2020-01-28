pipeline {
    agent any

    options {
        ansiColor('xterm')
    }

    environment {
        VAGRANT_CLOUD_TOKEN = credentials('vagrant-cloud')
        BASE_BOX_VERSION = "15.4"
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
                sh 'rm -rf roles output-virtualbox-ovf'
            }
        }
        stage ('Download Base Box') {
            when { 
                expression { return !fileExists("$HOME/.vagrant.d/boxes/jumperfly-VAGRANTSLASH-etcd-base-3.3/$BASE_BOX_VERSION/virtualbox/box.ovf") }
            }
            steps {
                sh "vagrant box add jumperfly/centos-7 --box-version $BASE_BOX_VERSION"
            }
        }
        stage('Build') {
            steps {
                sh 'packer build packer.json'
            }
        }
    }
}
