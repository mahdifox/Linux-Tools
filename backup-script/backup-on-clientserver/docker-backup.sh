#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2021_Apr ##
##     on host that must backed up      ##
##########################################

################# Usage ##################
##        run script with script        ##
##          from backup-server          ##
##########################################


mkdir -p /backup

cd /backup/

key_name='db';
#if container has the key name of db

db_con_id=`docker ps -a | grep $key_name | awk '{print $1}'`;
db_con_name=`docker inspect --format="{{.Name}}" $db_con_id | cut -d '/' -f2`

docker commit  -p $db_con_id  $db_con_name && docker save -o /backup/$key_name-$db_con_name.tar $db_con_name
