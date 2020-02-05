#!/bin/bash
#############################################
## $1 was params to backup or restore      ##
## $2 directory addres for restore backup  ##
#############################################


case "$1" in
    backup)
		mkdir -p /data/backup/
		mongodump --out=/data/backup/`date +"%Y%m%d"`/
		sudo rm -rf $(ls /data/backup/ -1t | tail -n +8)
	restor)
		mongorestore $2