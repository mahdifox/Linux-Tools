#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2020_Aug ##
##           checking if DA up          ##
##########################################

################# Usage ##################
##        run script without args       ##
##          as root via cron            ##
##########################################
while true
do
	if ! nc -w 1 -z localhost 2222
	then
		service directadmin restart;
		sleep 15;
	else
		# DirectAdmin is UP, so quit the script.
		exit 1;
	fi
done
