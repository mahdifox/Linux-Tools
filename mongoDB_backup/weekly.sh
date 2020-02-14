#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2020_Feb ##
##########################################
mkdir -p "/PATH_TO_YOUR_BACKUPS_FOLDER/weekly/"
#
#	 ------------------e.g.----------------
#	|
#	|
#	|
#	'---> /var/backups/mongo_backups/weekly/
#
mongodump  --out PATH_TO_YOUR_BACKUPS_FOLDER/weekly/`date +"%Y-%m-%d"`/
cd "/var/backups/mongobackups/weekly/"
rm -rf $(ls PATH_TO_YOUR_BACKUPS_FOLDER/weekly/ -1t | tail -n +8)
