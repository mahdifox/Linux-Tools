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
build_path="/usr/local/directadmin/custombuild";

#define style and color for printing logs
BOLD=$(tput bold);
NORMAL=$(tput sgr0);
GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m'

update=$1;
if [[ ! -z $update ]]
then
        logpath="/var/www/html/buildlog/";
        mkdir -p  "$logpath";
        echo -e "${GREEN} waiting for updates ... ${NC}";
        $build_path/build set_fastest 2> /dev/null;
        $build_path/build update 2> /dev/null;
        $build_path/build versions 2> /dev/null | grep "update is available" | awk  '{print $1}' | tr '[:upper:]' '[:lower:]' > $MY_PATH/available_updates.txt;
        cat $MY_PATH/available_updates.txt | cut -c5- > $MY_PATH/newfile

        sed -i $MY_PATH/newfile -e 's/s-nail/snail/g';
        sed -i $MY_PATH/newfile -e 's/exim.conf/exim_conf/g';
        sed -i $MY_PATH/newfile -e 's/Pure-FTPD/pure-ftpd/g';
        sed -i $MY_PATH/newfile -e 's/Pure-FTPd/pure-ftpd/g';
        sed -i $MY_PATH/newfile -e 's/dovecot.conf/dovecot_conf/g';

        echo -e "${GREEN} done ${NC}";
        if [ $update == "all" ]
        then
                echo "all_one";
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
                                                                                                cd "$build_path";
                                                                                                ./build $single_line;
                                                                                                if [ $? -eq 0 ]
                                                                                                then
                                                                                                        mkdir -p "$logpath/`date "+%Y-%m-%d"`";
                                                                                                        now_time=`date "+%T"`;
                                                                                                        echo -e "build ${BOLD}$line${NORMAL} ${GREEN}done${NC} at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`/build.log";
                                                                                                else
                                                                                                        mkdir -p "$logpath/`date "+%Y-%m-%d"`";
                                                                                                        now_time=`date "+%T"`;
                                                                                                        echo -e "build ${BOLD}$line${NORMAL} ${RED}failed{NC} at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`/build.err";
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
                done<$MY_PATH/newfile
        else
                while read line
                do
                        if [ $update == $line ]
                        then
                                $build_path/build $line;
                                if [ $? -eq 0 ]
                                then
                                        mkdir -p "$logpath/`date "+%Y-%m-%d"`";
                                        now_time=`date "+%T"`;
                                        echo -e "build ${BOLD}$line${NORMAL} ${GREEN}done${NC} at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`/build.log";
                                else
                                        mkdir -p "$logpath/`date "+%Y-%m-%d"`";
                                        now_time=`date "+%T"`;
                                        echo -e "build ${BOLD}$line${NORMAL} ${RED}failed{NC} at ${BOLD}$now_time${NORMAL}" > "$logpath/`date "+%Y-%m-%d"`/build.err";
                                fi
                                break;
                        fi
                done<$MY_PATH/newfile
        fi
else
        echo -e "${GREEN} waiting for updates ... ${NC}";
        $build_path/build set_fastest 2> /dev/null;
        $build_path/build update 2> /dev/null;
        $build_path/build versions 2> /dev/null | grep "update is available" | awk  '{print $1}' | tr '[:upper:]' '[:lower:]' > $MY_PATH/available_updates.txt;

        sed -i $MY_PATH/available_updates.txt -e 's/s-nail/snail/g';
        sed -i $MY_PATH/available_updates.txt -e 's/exim.conf/exim_conf/g';
        sed -i $MY_PATH/available_updates.txt -e 's/Pure-FTPD/pure-ftpd/g';
        sed -i $MY_PATH/available_updates.txt -e 's/Pure-FTPd/pure-ftpd/g';
        sed -i $MY_PATH/available_updates.txt -e 's/dovecot.conf/dovecot_conf/g';

        while read line2
        do
                available_updates="$line2 | $available_updates";
        done<$MY_PATH/available_updates.txt
        echo $"Usage: $0 { "$available_updates"all }";
fi
