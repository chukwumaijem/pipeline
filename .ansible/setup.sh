#!/bin/sh

fileName="inventory.txt"

touch $fileName

echo [all] > $fileName

aws ec2 describe-instances --query 'Reservations[*].Instances[*].PublicIpAddress' \
  --filters "Name=tag:Project,Values=udacity" \
  --output text >> $fileName

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook main-remote.yml -i inventory.txt --private-key AnsibleTest.pem
