#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2020_Feb ##
##########################################
mkdir -p "/PATH_TO_YOUR_BACKUPS_FOLDER/hourly/"
#
#	 ------------------e.g.----------------
#	|
#	|
#	|
#	'---> /var/backups/mongo_backups/hourly/
#
mongodump  --out PATH_TO_YOUR_BACKUPS_FOLDER/hourly/`date +"%Y-%m-%d_%H:%M:%S"`/
cd "/var/backups/mongobackups/hourly/"
rm -rf $(ls PATH_TO_YOUR_BACKUPS_FOLDER/hourly/ -1t | tail -n +25);
