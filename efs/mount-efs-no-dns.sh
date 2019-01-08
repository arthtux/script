#!/usr/bin/env bash

EFS_DNS=".efs.us-east-1.amazonaws.com"
DNS_SERVER_IP="DNS IP"
EFS_MOUNT_POINT="DIR MOUNT"

EFS_IP=$(dig ${EFS_DNS} @${DNS_SERVER_IP} | grep ${EFS_DNS} | awk '{print $5}' | tail -1)

if [[ ! -d ${EFS_MOUNT_POINT} ]]; then
  mkdir -p ${EFS_MOUNT_POINT}
  echo "Create EFS mount point: ${EFS_MOUNT_POINT}."
fi

if [[ $EFS_IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
  mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${EFS_IP}:/   ${EFS_MOUNT_POINT}
else
  echo "Sorry the ip is not found."
fi
