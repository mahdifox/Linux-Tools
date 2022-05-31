#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2022_JUN ##
##########################################
mkdir -p "/PATH_TO_BACKUP/weekly/"
#
#	 ------------------e.g.----------------
#	|
#	|
#	|
#	'---> /var/backups/mongo_backups/weekly/
#
mongodump --forceTableScan --host IP --port PORT --username USERNAME --password PASSWORD --authenticationDatabase admin --out /PATH_TO_BACKUP/weekly/`date +"%Y-%m-%d"`/
cd "/PATH_TO_BACKUP/weekly/"
rm -rf $(ls /PATH_TO_BACKUP/weekly/ -1t | tail -n +8)
