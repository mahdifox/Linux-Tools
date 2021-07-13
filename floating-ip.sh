#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2021_Jul ##
##########################################

################# Usage ##################
##     run script with command line     ##
##########################################

#define color for print and echo.
NC='\033[0m';         # NO COLOR
Red='\033[0;91m';     # Red
White='\033[1;97m';   # White
Green='\033[0;92m';   # Green
Yellow='\033[0;93m';  # Yellow

source /root/admin-keystone;
openstack server list --all;
echo -e "${White}Hi, This is for adding or removing float-ip from a VM in openstack${NC} ${Green}:)${NC}";
echo -e "${White}Will you please tell me uuid of the server you wish to change:${NC}"
read uuid;
echo -e "${White}please select${NC} ${Green}1 ( to add ) ${NC}${White}or${NC} ${Red}2 ( to remove )${NC}";
read option;
case "$option" in
    1)
	echo -e "${White} Checking the VM network, Please wait${NC} ${GREEN}... ${NC}";
	openstack server list --all | grep "$uuid" > /root/.tmp.txt;
	cat /root/.tmp.txt | grep "xxx.xxx.xx" > /dev/null; #Replace xxx.xxx.xx with your IP range
        if [ $? -eq 0 ]
        then
		echo -e "${Red}Error:${NC} ${Yellow}Humm it seems that, a floating ip has already assign to the selected VM, sorry please double check${NC} ${Red}:(${NC}";
	else
		echo -e "${Green}OK${NC}${White}, I'll do it ASAP, please wait${NC} ${Green}...${NC}";
		users_project_id=`mysql -e "select project_id from nova.instances where uuid='$uuid';" | tail -n+2`;
		openstack floating ip create --project $users_project_id --subnet subnet-public network-public > /root/.tmp.txt;
		floating_ip="`cat /root/.tmp.txt  | grep floating_ip_address | cut -d '|' -f3 | cut -d ' ' -f2`";
		rm -rf /root/.tmp.txt;
		openstack server add floating ip $uuid $floating_ip;
		openstack server list --all | grep "$uuid" > /root/.tmp.txt;
		floating_ip=`cat /root/.tmp.txt | cut -d '|' -f5 | cut -d ',' -f2 | cut -d ' ' -f2`;
		echo -e "${White}The floating ip assigned to VM is:${NC}${Green} $floating_ip ${NC}";
		echo -e "${Green}Done :)${NC}";
        fi
	rm -rf /root/.tmp.txt > /dev/null;
	;;
    2)
	echo -e "${White} Checking the VM network, Please wait${NC} ${GREEN}... ${NC}";
	openstack server list --all | grep "$uuid" > /root/.tmp.txt;
	cat /root/.tmp.txt | grep "109.122.25" > /dev/null;
	if [ $? -eq 0 ]
	then
                echo -e "${Green}OK${NC}${White}, I'll do it ASAP, please wait${NC} ${Green}...${NC}";
		floating_ip=`cat /root/.tmp.txt | cut -d '|' -f5 | cut -d ',' -f2 | cut -d ' ' -f2`;
		openstack server remove floating ip $uuid $floating_ip;
		openstack floating ip delete $floating_ip;
		echo -e "${White}The floating ip ${NC}${Green}$floating_ip${NC}${White}successfully${NC} ${Green}removed${NC} ${White}from seleted VM${NC}${Green} :) ${NC}";
                echo -e "${Green}Done :)${NC}";
	else
		echo -e "${Red}Error:${NC}${Yellow}Humm it seems that, the selected VM has no floating ip, sorry please double check it${NC} ${Red}:(${NC}";
	fi
	rm -rf /root/.tmp.txt > /dev/null;
	;;
    *)
        echo -e $"${White}Usage:${NC} $0 ${White}{${NC} ${Green}1 ( to add ) ${White}|${NC} ${Red}2 ( to remove )${NC}${White} }${NC}"
esac
