#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2022_JUN ##
##########################################
mkdir -p "/PATH_TO_BACKUP/hourly/"
#
#	 ------------------e.g.----------------
#	|
#	|
#	|
#	'---> /var/backups/mongo_backups/hourly/
#
mongodump --forceTableScan --host IP --port PORT --username USERNAME --password PASSWORD --authenticationDatabase admin --out /PATH_TO_BACKUP/hourly/`date +"%Y-%m-%d_%H:%M:%S"`/
cd "/PATH_TO_BACKUP/hourly/"
rm -rf $(ls /PATH_TO_BACKUP/hourly/ -1t | tail -n +25);
