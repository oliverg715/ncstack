#!/bin/bash

pushd /home/administrator/nextcloud-fullstack

[ -d ./backups ] || mkdir ./backups

#create the list of files to backup
echo "./docker-compose.yaml" >list.txt
echo "/opt/containers/nextcloud/" >>list.txt
echo "/opt/containers/traefik/" >>list.txt

#setup variables
logfile=./backups/backup.log
backupfile="backup-$(date +"%Y-%m-%d_%H%M").tar.gz"

#compress the backups folders to archive
echo "compressing stack folders"
sudo tar -czf \
	./backups/$backupfile \
	-T list.txt

rm list.txt

#set permission for backup files
sudo chown root:root ./backups/backup*

#create local logfile and append the latest backup file to it
echo "backup saved to ./backups/$backupfile"
sudo touch $logfile
sudo chown root:root $logfile
echo $backupfile >>$logfile

#show size of archive file
du -h ./backups/$backupfile

#remove older local backup files
#to change backups retained,  change below +8 to whatever you want (days retained +1)
ls -t1 ./backups/backup* | tail -n +8 | sudo xargs rm -f
echo "last seven local backup files are saved in ~/nextcloud-fullstack/backups"

popd
