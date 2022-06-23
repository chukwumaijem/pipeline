#!/bin/sh

fileName="inventory.txt"

touch $fileName

echo [all] > $fileName

aws ec2 describe-instances --query 'Reservations[*].Instances[*].PublicIpAddress' \
  --filters "Name=tag:Project,Values=udacity" \
  --output text >> $fileName

# Create ansible config file
configFile = "ansible.cfg"
touch $configFile

echo [defaults] > $configFile
echo host_key_checking = false >> $configFile

ansible-playbook main-remote.yml -i inventory.txt
