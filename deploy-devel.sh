#!/bin/bash

ANSIBLE_CONFIG=configs/development.cfg ansible-playbook -i inventories/development playbook.yml "$@"
