#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2021_Apr ##
##    backup on your-backup-server      ##
##########################################

################# Usage ##################
##       run script with crontab,       ##
##########################################

#Configuration
ip="x.x.x.x";
name="backup-folder"; #created under /backup of your backup-server
period="monthly";

#Command
mkdir -p "/backup/$name/$period" && ssh root@$ip "/backup-script.sh" && scp "root@$ip:/backup/*.tar.gz"  "/backup/$name/$period";
ssh root@$ip "rm -rf /backup"; 

cd /backup/$name/$period/;
rm -rf $(ls -lap /backup/$name/$period/ -1t | grep -v "/" | tail -n+2 | tail -n+7 | awk '{print $9}');
