#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2022_JUN ##
##########################################
mkdir -p "/PATH_TO_BACKUP/monthly/"
#
#	 ------------------e.g.-----------------
#	|
#	|
#	|
#	'---> /var/backups/mongo_backups/monthly/
#
mongodump --forceTableScan --host IP --port PORT --username USERNAME --password PASSWORD --authenticationDatabase admin --out /PATH_TO_BACKUP/monthly/`date +"%Y-%m-%d"`/
cd "/PATH_TO_BACKUP/monthly/"
rm -rf $(ls /PATH_TO_BACKUP/monthly/ -1t | tail -n +8)
