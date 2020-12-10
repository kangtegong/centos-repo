#!/bin/bash
# for production use '192.168.0.8::CentOS' instead of 'msync.centos.org::CentOS'
echo "$(date) START $0"
flock -n -E 2 /data/centos -c 'timeout 4h rsync -aqzH4 --delay-updates --timeout 3600 --delete msync.centos.org::CentOS /data/centos/'
if [ "$?" -eq '2' ]; then
  echo "$(date) ($0): cannot get lock, skipping this script"
  exit 2
fi
echo "$(date) FINISH $0"
