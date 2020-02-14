#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2020_Feb ##
##########################################
mkdir -p "/PATH_TO_YOUR_BACKUPS_FOLDER/daily/"
#
#	 ------------------e.g.----------------
#	|
#	|
#	|
#	'---> /var/backups/mongo_backups/daily/
#
mongodump  --out /PATH_TO_YOUR_BACKUPS_FOLDER/daily/`date +"%Y-%m-%d"`/
cd "/PATH_TO_YOUR_BACKUPS_FOLDER/daily/"
rm -rf $(ls /PATH_TO_YOUR_BACKUPS_FOLDER/daily/ -1t | tail -n +8);
