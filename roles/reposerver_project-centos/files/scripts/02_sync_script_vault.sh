#!/bin/bash
# for testing use '192.168.0.8::centos-vault' instead of 'linuxsoft.cern.ch::centos-vault'
echo "$(date) START $0"
flock -n -E 2 /data/centos-vault -c 'rsync -aqzH --include="5.11**" --include="/TIME" --include="/RPM-GPG-KEY-CentOS-5" --exclude="*" linuxsoft.cern.ch::centos-vault /data/centos-vault/'
if [ "$?" -eq '2' ]; then
  echo "$(date) ($0): cannot get lock, skipping this script"
  exit 2
fi
echo "$(date) FINISH $0"
