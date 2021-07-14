#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2021_Jul ##
##########################################

################# Usage ##################
##     run script with command line     ##
##########################################

#Spin_Mode
spin[0]="-"
spin[1]="\\"
spin[2]="|"
spin[3]="/"

#define color for print and echo.
NC='\033[0m';         # NO COLOR
Red='\033[0;91m';     # Red
White='\033[1;97m';   # White
Green='\033[0;92m';   # Green
Yellow='\033[0;93m';  # Yellow

source /root/admin-keystone;
openstack server list --all & PID=$!;
echo -e "${White}Listing all servers${NC}"
while kill -0 $PID 2> /dev/null;
do
	for i in "${spin[@]}"
	do
		echo -ne "\b$i"
		sleep 0.1
	done
done
echo "";
echo -e "${White}Hi, This is for adding or removing float-ip from a VM in openstack${NC} ${Green}:)${NC}";
echo -e "${White}Will you please tell me uuid of the server you wish to change:${NC}"
read uuid;
echo "";
count_uuid=$(echo -n "$uuid" | wc -c);
if [ $count_uuid -eq 36 ]
then
	echo -e "${White}please select${NC} ${Green}1 ( to add ) ${NC}${White}or${NC} ${Red}2 ( to remove )${NC}";
	read option;
	echo "";
	case "$option" in
		1)
			echo -e "${White}Checking the VM network${NC}";
			openstack server list --all | grep "$uuid" > /root/.tmp.txt & PID=$!
			while kill -0 $PID 2> /dev/null;
			do
				for i in "${spin[@]}"
				do
					echo -ne "\b$i"
					sleep 0.1
				done
			done
			echo "";
			cat /root/.tmp.txt | grep "109.122.25" > /dev/null;
		        if [ $? -eq 0 ]
		        then
				echo -e "${Red}Error:${NC} ${Yellow}Humm it seems that, a floating ip has already assign to the selected VM, sorry please double check${NC} ${Red}:(${NC}";
			else
				echo -e "${Green}OK,${NC}${White} The server is compatible for Floating-IP allocation${NC}";
				echo -e "${White}Start allocating${NC}";
				users_project_id=`mysql -e "select project_id from nova.instances where uuid='$uuid';" | tail -n+2`;
				openstack floating ip create --project $users_project_id --subnet subnet-public network-public > /root/.tmp.txt & PID=$!;
				echo -e "${White}[1/3]${NC}"
				while kill -0 $PID 2> /dev/null;
				do
				        for i in "${spin[@]}"
        				do
				                echo -ne "\b$i"
				                sleep 0.1
				        done
				done
				echo "";
				floating_ip="`cat /root/.tmp.txt  | grep floating_ip_address | cut -d '|' -f3 | cut -d ' ' -f2`";
				rm -rf /root/.tmp.txt;
				openstack server add floating ip $uuid $floating_ip & PID=$!;
                                echo -e "${White}[2/3]${NC}"
                                while kill -0 $PID 2> /dev/null;
                                do
                                        for i in "${spin[@]}"
                                        do
                                                echo -ne "\b$i"
                                                sleep 0.1
                                        done
                                done
                                echo "";
				openstack server list --all | grep "$uuid" > /root/.tmp.txt & PID=$!;
                                echo -e "${White}[3/3]${NC}"
                                while kill -0 $PID 2> /dev/null;
                                do
                                        for i in "${spin[@]}"
                                        do
                                                echo -ne "\b$i"
                                                sleep 0.1
                                        done
                                done
                                echo "";
				
				floating_ip=`cat /root/.tmp.txt | cut -d '|' -f5 | cut -d ',' -f2 | cut -d ' ' -f2`;
				echo -e "${White}The floating ip assigned to VM is:${NC}${Green} $floating_ip ${NC}";
				echo "";
				echo -e "${Green}Done :)${NC}";
				echo "";
	        	fi
			rm -rf /root/.tmp.txt > /dev/null;
			;;
	    	2)
			echo -e "${White}Checking the VM network${NC}";
			openstack server list --all | grep "$uuid" > /root/.tmp.txt & PID=$!;
			while kill -0 $PID 2> /dev/null;
			do
		        	for i in "${spin[@]}"
		        	do
		                	echo -ne "\b$i"
			                sleep 0.1
			        done
			done
			echo "";

			cat /root/.tmp.txt | grep "109.122.25" > /dev/null;
			if [ $? -eq 0 ]
			then
		                echo -e "${Green}OK,${NC}${White} The server is compatible for Floating-IP allocation${NC}";
				echo -e "${White}Start allocating${NC}";
				floating_ip=`cat /root/.tmp.txt | cut -d '|' -f5 | cut -d ',' -f2 | cut -d ' ' -f2`;
				openstack server remove floating ip $uuid $floating_ip & PID=$!;
				echo -e "${White}[1/2]${NC}"
				while kill -0 $PID 2> /dev/null;
				do
                                	for i in "${spin[@]}"
					do
						echo -ne "\b$i"
						sleep 0.1
					done
				done
				echo "";
				openstack floating ip delete $floating_ip & PID=$!;
				echo -e "${White}[2/2]${NC}"
                                while kill -0 $PID 2> /dev/null;
                                do
                                        for i in "${spin[@]}"
                                        do      
                                                echo -ne "\b$i"
                                                sleep 0.1
                                        done
                                done
                                echo "";
				echo -e "${White}The floating ip ${NC}${Green}$floating_ip${NC} ${White}successfully${NC} ${Green}removed${NC} ${White}from seleted VM${NC}${Green} :) ${NC}";
				echo "";
		                echo -e "${Green}Done :)${NC}";
				echo "";
			else
				echo "";
				echo -e "${Red}Error:${NC}${Yellow}Humm it seems that, the selected VM has no floating ip, sorry please double check it${NC} ${Red}:(${NC}";
			fi
			rm -rf /root/.tmp.txt > /dev/null;
			;;
		*)
		        echo -e $"${White}Usage:${NC} $0 ${White}{${NC} ${Green}1 ( to add ) ${White}|${NC} ${Red}2 ( to remove )${NC}${White} }${NC}"
	esac
else
	echo -e "${Red}Error:${NC}${Yellow}Wrong UUID, Please double check the server's ID${NC} ${Red}:(${NC}";
fi
