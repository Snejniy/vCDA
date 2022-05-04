#! /bin/bash

## Get current date ##
_date=$(date +"%Y-%m-%d-%H-%M")

## Authenticationon job ##
echo "Starting Authenticationon on VCDA" \

source /home/scripts/vcda_auth.cfg
vcdaname=$(eval echo ${VCDA_NAME})
vcdauser=$(eval echo ${VCDA_USER})
vcdapass=$(eval echo ${VCDA_PASSWORD} | base64 --decode)

Auth=$(curl -k "https://$vcdaname:8046/sessions" -i -X POST \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/vnd.vmware.h4-v4.3+json;charset=UTF-8' \
    -d '{
  "type" : "localUser",
  "localUser" : "'"$vcdauser"'",
  "localPassword" : "'"$vcdapass"'"
}' | grep X-VCAV-Auth | cut -d " " -f2)

## Run backup job ##
echo "Starting backup VCDA" \

curl -k 'https://localhost:8046/backups' -i -X POST \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/vnd.vmware.h4-v4.3+json;charset=UTF-8' \
    -H "X-VCAV-Auth: $Auth" \
    -d '{
  "password" : "Pa$$w0rD!"
}'

echo "Backup VCDA have been successfully" \

##  Retention old backup policy ##

echo "Findining old backups" \

oldbkpid=$(find /opt/vmware/h4/cloud/backup/ -type f -name '*.*' -mtime +7 | cut -d / -f8 | cut -d . -f1 | cut -d'-' -f 2- | head -1)

echo "Starting deleting old backup" \

curl -k "https://localhost:8046/backups/$oldbkpid" -i -X DELETE \
    -H 'Accept: application/vnd.vmware.h4-v4.3+json;charset=UTF-8' \
    -H "X-VCAV-Auth: $Auth"

echo "Old backup successfully deleted" \
