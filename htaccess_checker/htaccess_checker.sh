#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2020_Jan ##
##     htaccess checker for prevent     ##
##         misuse of resources          ##
##########################################

################# Usage ##################
##  run script from server's cronetab   ##
##    as root, no arguments needed      ##
##########################################

#define color for print or echo
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# log file path defines here.
LOG_PATH="/var/log/htaccess_checker";
mkdir -p $LOG_PATH;


# declare an array to get user-id and home-directory
# of all linux users according to /etc/passwd file named p.
declare -A p=()
while IFS=: read -r x x uid x x home x
do
    p[$uid]=$home
done </etc/passwd


# using of array p.
for uid in "${!p[@]}"
do

    # checking which users are initial users.
    if [ $uid -gt 999 ] && [ $uid -lt 60001 ]
    then

	# checking if .htaccess file exists in the user's home directory or not.
	if [ -f "${p[$uid]}/public_html/.htaccess" ]
	then
	    
	    # checking a foreign file for php values that must be.
	    # !IMPORTANT: the file must be in the same path of this script file.
	    while read value
	    do
		
		#checking if every single php value from the foreign file exists in htaccess file of user's home-directory or not.
	   	if grep -q $value "${p[$uid]}/public_html/.htaccess";
	   	then
		   	HT_PATH="${p[$uid]}/public_html/.htaccess";
		   	USERNAME=`echo "${p[$uid]}" |cut -d\/ -f3`;
		   	#comment the line including illegal php value.
			sed -e '/'"$value"'/ s/^#*/#/' -i "$HT_PATH";
		   	#setting the privilege of htaccess to root and read-only.
			chown  root.root "$HT_PATH";
		   	chmod  400    	 "$HT_PATH";
			#printing the event log in the log file defined at the top of this script.
			now_date=`date "+%T %Y-%m-%d"`;
		   	echo -e "The user ${RED}$USERNAME${NC} has been blocked, illegal using of ${RED}$value${NC} value in ${RED}${p[$uid]}/public_html/.htaccess${NC} file at ${GREEN}$now_date${NC}\n" >> "$LOG_PATH/blocked";
	   	fi
	    done <./php_values
	fi
    fi
done
