#!/bin/bash

ANSIBLE_CONFIG=configs/production.cfg ansible-playbook -i inventories/production playbook.yml "$@"

if [ -f ~/.google/devopsgooglecredentials.json ];
then
    echo 'Logging production deployment activity'
    source /root/prod-deploy-log/bin/activate
    python scripts/prod-deploy-log.py $REMOTE_USER "$*"
    deactivate
fi

