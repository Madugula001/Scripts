#!/bin/bash

ANSIBLE_CONFIG=configs/staging.cfg ansible-playbook -i inventories/staging playbook.yml "$@"
