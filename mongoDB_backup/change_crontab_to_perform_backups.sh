##########################################
## Created_By_Mahdi_Bagheri_at_2020_Feb ##
##########################################
#
################## Usage #################
##      To take mongoDB backups         ##
##      run `chmod +x hourly.sh`        ##
##      run `chmod +x daily.sh`         ##
##      run `chmod +x weekly.sh`        ##
##      run `chmod +x monthly.sh`       ##
##    run `crontab -e` on Terminal      ##
##   paste this file on it and save     ##
##########################################
#
#min	hour	dom	mon	dow	command
#
17      *       *       *       *       /FULL_PATH_TO_SCRIPTS_FOLDER/hourly.sh
25      6       *       *       *       /FULL_PATH_TO_SCRIPTS_FOLDER/daily.sh
47      6       *       *       5       /FULL_PATH_TO_SCRIPTS_FOLDER/weekly.sh
52      6       1       *       *       /FULL_PATH_TO_SCRIPTS_FOLDER/monthly.sh
#
#				 	 ---------e.g.--------------
#					|
#					|
#					|
#					'--> /var/backups/mongo_backups/scripts/
