#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2022_Mar ##
##########################################

################# Usage ##################
##    run script simple ./script.sh     ##
##########################################

whois_installed=`dpkg -l | grep whois | cut -d " " -f1`
if [[ "$whois_installed" -ne "ii" ]]
then
	apt update;
	apt install whois;
fi
whois $(dig @resolver4.opendns.com myip.opendns.com +short) | grep -i '^country:\|^descr:\|^address:'
