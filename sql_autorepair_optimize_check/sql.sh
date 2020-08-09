#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2020_Aug ##
##	  check optimize autorepair	##
##	        in mysql		##
##########################################

################# Usage ##################
##	  run script without args	##
##	      to see all db		##
##					##
##	  all or db argument needed	##
##		to run correctly        ##
##########################################


MY_PATH="`dirname \"$0\"`"			  # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

#define style and color for printing logs
BOLD=$(tput bold);
NORMAL=$(tput sgr0);
GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m'

dbuser=`cat /usr/local/directadmin/conf/my.cnf  | grep user | cut -d'=' -f2`;
dbpass=`cat /usr/local/directadmin/conf/my.cnf  | grep password | cut -d'=' -f2`;
mysql -u$dbuser -p$dbpass -e 'show databases;' | grep -v "|" | grep -v "Database\|information_schema\|performance_schema\|mysql" > $MY_PATH/all_dbs;

update=$1;
if [[ ! -z $update ]]
then
		logpath="/var/www/html/SQL_script";
		mkdir -p  "$logpath";

	if [ $update == "all" ]
		then
		echo -e "${GREEN} waiting for fetching all databases ... ${NC}";
			echo -e "${GREEN} done ${NC}";
		while read line
		do
				#mysqlcheck -u$dbuser -p$dbpass --auto-repair $line
				#mysqlcheck -u$dbuser -p$dbpass --optimize $line
				#mysqlcheck -u$dbuser -p$dbpass --check $line
			echo "$line done";
			if [ $? -eq 0 ]
				then
					mkdir -p "$logpath/`date "+%Y-%m-%d"`";
					now_time=`date "+%T"`;
					echo -e "auto-repair, optimize and check ${GREEN}done${NC} for ${GREEN}$line${NC} database at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`/sql_script.log";
				else
					mkdir -p "$logpath/`date "+%Y-%m-%d"`";
										now_time=`date "+%T"`;
					echo -e "auto-repair, optimize and check ${RED}failed${NC} for ${RED}$line${NC} database at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`/sql_script.err.log";
			fi
		done<$MY_PATH/all_dbs;
	else
		while read line2
		do
			if [ $update == $line2 ]
				#mysqlcheck -u$dbuser -p$dbpass --auto-repair $line2
				#mysqlcheck -u$dbuser -p$dbpass --optimize $line2
				#mysqlcheck -u$dbuser -p$dbpass --check $line2
				echo "$line2 done";
				if [ $? -eq 0 ]
					then
							mkdir -p "$logpath/`date "+%Y-%m-%d"`";
							now_time=`date "+%T"`;
							echo -e "auto-repair, optimize and check ${GREEN}done${NC} for ${GREEN}$line${NC} database at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`/sql_script.log";
					else
							mkdir -p "$logpath/`date "+%Y-%m-%d"`";
							now_time=`date "+%T"`;
				fi			echo -e "auto-repair, optimize and check ${RED}failed${NC} for ${RED}$line${NC} database at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`/sql_script.err.log";
			fi
		done<$MY_PATH/all_dbs;
	fi
else
	echo -e "${GREEN} waiting for fetching all databases ... ${NC}";
	echo -e "${GREEN} done ${NC}";	
	while read line3
	do
			available_dbs="$line3 | $available_dbs";
	done<$MY_PATH/all_dbs;
	echo $"Usage: $0 { "$available_dbs"all }";
fi

