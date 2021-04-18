#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2021_Apr ##
##       openstack user activation      ##
##           victoria version           ##
##########################################

################# Usage ##################
##    run script with client email,     ##
##    i.e., mahdifox2000@gmail.com      ##
##########################################

BOLD=$(tput bold);
NORMAL=$(tput sgr0);
GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m';

user_domain_name=$1;
if [[ ! -z $user_domain_name ]]
then
	#assume authentication file is under /etc/kolla/
	source /etc/kolla/admin-openrc.sh;
	openstack user list --domain $user_domain_name > /root/.temp_user_domain 2> /dev/null;
	if [ $? -eq 0 ]
	then
		hashed_user_id=`cat /root/.temp_user_domain  | awk '{print $2}' | tail -n-2 | head -n1`;
		openstack user set --enable $hashed_user_id
		openstack domain set --enable $user_domain_name
		echo -e "user ${GREEN}'$hashed_user_id'${NC} with domain name ${GREEN}'$user_domain_name'${NC} is now ${GREEN}'activated :) happy openstacking'${NC} "
	else
		echo -e "${RED}No${NC} ${BOLD}domain with a name or ID of${NORMAL} '$user_domain_name' ${RED}exists. :(${NC}"
	fi
	rm -rf /root/.temp_user_domain
else
	echo -e "${BOLD}No Domain(email) passed to activate${NORMAL}";
	echo -e $"Usage: ${GREEN}$0${NC} { ${GREEN}mahdifox2000@gmail.com (a valid user's domain name)${NC} }";
fi
