#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2020_Jun ##
##       htaccess checker for prevent   ##
##               misuse of resources    ##
##########################################

################# Usage ##################
##  run script from server's cronetab   ##
##      as root, no arguments needed    ##
##########################################

#MY_PATH filled with the executinve script path
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
        # error; for some reason, the path is not accessible
        # to the script (e.g. permissions re-evaled after suid)
        exit 1  # fail
fi

#define color for print or echo
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# log file path defines here.
LOG_PATH="/var/log/htaccess_checker";
mkdir -p $LOG_PATH;

# declare p array to get user-id and home-directory of all linux users according to /etc/passwd file.
declare -A p=()
while IFS=: read -r x x uid x x home x
do
        p[$uid]=$home
done </etc/passwd

# checking which users are usual users.
user_id_min=`cat /etc/login.defs | grep "^UID_MIN" | awk '{print $2}'`
user_id_max=`cat /etc/login.defs | grep "^UID_MAX" | awk '{print $2}'`

# checking every single php_value
while read php_value
do
        #  using p array.
        for uid in "${!p[@]}"
        do
                if [ $uid -ge $user_id_min ] && [ $uid -le $user_id_max ]
                then
                        # geting exact username in USERNAME variable.
                        USERNAME=`echo "${p[$uid]}" |cut -d\/ -f3`;
                        # checking if username is one of clients.
                        if [ $USERNAME != "mahdi" ]
                        then
                                # checking if .htaccess file exists in user's public_html or sub-directories and store them to .all_htaccess under user's home-directory.
                                if grep -q "$php_value" "${p[$uid]}/.htaccess"
                                then
                                        ht_path="${p[$uid]}/.htaccess"
                                        # delete the illegal php_value in ht_path .htaccess file.
                                        sed "/$php_value/d" -i "$ht_path";
                                        # geting now date for log exact time
                                        now_date=`date "+%T %Y-%m-%d"`;
                                        # printing  event log in the log file defined at the top of script ( $LOG_PATH/blocked ).
                                        echo -e "The user ${RED}$USERNAME${NC} has been blocked, illegal using of ${RED}$php_value${NC} value in ${RED}$ht_path${NC} file at ${GREEN}$now_date${NC}\n" >> "$LOG_PATH/blocked";
                                fi
                                if grep -q "$php_value" "${p[$uid]}/.htaccess"
                                        ht_path="${p[$uid]}/.htaccess"
                                        # delete the illegal php_value in ht_path .htaccess file.
                                        sed "/$php_value/d" -i "$ht_path";
                                        # geting now date for log exact time
                                        now_date=`date "+%T %Y-%m-%d"`;
                                        # printing  event log in the log file defined at the top of script ( $LOG_PATH/blocked ).
                                        echo -e "The user ${RED}$USERNAME${NC} has been blocked, illegal using of ${RED}$php_value${NC} value in ${RED}$ht_path${NC} file at ${GREEN}$now_date${NC}\n" >> "$LOG_PATH/blocked";
                                fi
                        fi
                fi
        done
done < "$MY_PATH/php_values"
# everything is done now...
