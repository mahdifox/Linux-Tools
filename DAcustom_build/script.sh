#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2020_Jul ##
##       direct admin custom build      ##
##      to build available updates      ##
##########################################

################# Usage ##################
##      run script without args         ##
##      to see available updats         ##
##                                      ##
##  run script from server's cronetab   ##
##    as root, update argument needed   ##
##########################################


MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

#directadmin default installed path
build_path="/usr/local/directadmin/custombuild/";

#define style and color for printing logs
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

update="$1";
if [[ ! -z $update ]]
then
	logpath="/var/www/html/buildlog/";
	mkdir -p  "$logpath";
	echo "waiting for updates ...";
	$build_path/build set_fastest 2> /dev/null;
	$build_path/build update 2> /dev/null;
	$build_path/build versions 2> /dev/null | grep "update is available" | awk  '{print $1}' | tr '[:upper:]' '[:lower:]' > $MY_PATH/available_updates;
	
	sed -i $MY_PATH/available_updates -e 's/s-nail/snail/g';
	sed -i $MY_PATH/available_updates -e 's/exim.conf/exim_conf/g';
	sed -i $MY_PATH/available_updates -e 's/Pure-FTPD/pure-ftpd/g';
	sed -i $MY_PATH/available_updates -e 's/Pure-FTPd/pure-ftpd/g';
	sed -i $MY_PATH/available_updates -e 's/dovecot.conf/dovecot_conf/g';
	
	echo "done";
	if [ $update = "all" ]
	then
		while read single_line
		do
			if [ $single_line != "php" ]
			then
				if [ $single_line != "mysql" ]
				then
					if [ $single_line != "nginx" ]
					then
						if [ $single_line != "apache" ]
						then
							if [ $single_line != "litespeed" ]
							then 
								if [ $single_line != "nginx_apache" ]
								then
									if [ $single_line != "openlitespeed" ]
									then
										if [ $single_line != "litespeed_license" ]
										then
											if [ $single_line != "litespeed_license_migrate" ]
											then
												$build_path/build $single_line;
												if [ $? -eq 0 ]
												then
													mkdir -p "$logpath/`date "+%Y-%m-%d"`";
													now_time=`date "+%T"`;
													echo "build ${BOLD}$line${NORMAL} ${GREEN}done${NC} at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`";
												else
													mkdir -p "$logpath/`date "+%Y-%m-%d"`";
													now_time=`date "+%T"`;
													echo "build ${BOLD}$line${NORMAL} ${RED}failed{NC} at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`";
												fi
											fi
										fi
									fi
								fi
							fi
						fi
					fi
				fi				 
			fi									 
		done<$MY_PATH/available_updates
	else
		while read line
		do
			if [ $update = $line ]
			then
				$build_path/build $line;
				if [ $? -eq 0 ]
				then
					mkdir -p "$logpath/`date "+%Y-%m-%d"`";
					now_time=`date "+%T"`;
					echo "build ${BOLD}$line${NORMAL} ${GREEN}done${NC} at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`";
				else
					mkdir -p "$logpath/`date "+%Y-%m-%d"`";
					now_time=`date "+%T"`;
					echo "build ${BOLD}$line${NORMAL} ${RED}failed{NC} at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`";
				fi
				break;
			fi
		done<$MY_PATH/available_updates
	fi
else
	sed -i $MY_PATH/available_updates -e 's/s-nail/snail/g';
	sed -i $MY_PATH/available_updates -e 's/exim.conf/exim_conf/g';
	sed -i $MY_PATH/available_updates -e 's/Pure-FTPD/pure-ftpd/g';
	sed -i $MY_PATH/available_updates -e 's/Pure-FTPd/pure-ftpd/g';
	sed -i $MY_PATH/available_updates -e 's/dovecot.conf/dovecot_conf/g';
	
	while read line
	do
		available_updates="$line | $available_updates";
	done<$MY_PATH/available_updates
	echo $"Usage: $0 { "$available_updates"all }";
fi
