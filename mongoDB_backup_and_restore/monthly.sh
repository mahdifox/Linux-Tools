#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2020_Feb ##
##########################################
mkdir -p "/PATH_TO_YOUR_BACKUPS_FOLDER/monthly/"
#
#	 ------------------e.g.-----------------
#	|
#	|
#	|
#	'---> /var/backups/mongo_backups/monthly/
#
mongodump  --out PATH_TO_YOUR_BACKUPS_FOLDER/monthly/`date +"%Y-%m-%d"`/
cd "/PATH_TO_YOUR_BACKUPS_FOLDER/monthly/"
rm -rf $(ls PATH_TO_YOUR_BACKUPS_FOLDER/monthly/ -1t | tail -n +8)
