#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2022_JUN ##
##########################################
mkdir -p "/PATH_TO_BACKUP/daily/"
#
#	 ------------------e.g.----------------
#	|
#	|
#	|
#	'---> /var/backups/mongo_backups/daily/
#
mongodump --forceTableScan --host IP --port PORT --username USERNAME --password PASSWORD --authenticationDatabase admin --out /PATH/TO/BACKUP/daily/`date +"%Y-%m-%d"`/
cd "/PATH_TO_BACKUP/daily"
rm -rf $(ls /PATH_TO_BACKUP/daily -1t | tail -n +8);
