#!/bin/bash

ANSIBLE_CONFIG=configs/vagrant.cfg ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory playbook.yml "$@"
