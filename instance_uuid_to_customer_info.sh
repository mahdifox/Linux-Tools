#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2021_May ##
##########################################

################# Usage ##################
##     run script with command line     ##
##########################################

#define color for print and echo.
GREEN='\033[0;32m';
NC='\033[0m';

#mysql_databases_identity.
mysql_user='<dbuser>';
mysql_pass='<dbpass>';

#define api_server ip address.
api_server_ip=<api_server_ip>

#login to openstack.
source /root/admin-keystone;

#list all server of all openstack projects.
nova list --all;

echo "please input uuid of vm you wish to get user-email-address from:";
echo "";

#get the instance uuid from admin.
read instance_uuid;

#create a hidden temp file for further usage.
touch /root/.tmp.txt

#connect to database OPENSTACK.
mysql -u$mysql_user -p$mysql_pass -e "SELECT extra FROM keystone.user WHERE id IN (SELECT user_id FROM nova.instances WHERE uuid='$instance_uuid');" > /root/.tmp.txt;

#get the user's email.
email=`cat .tmp.txt | tail -n +2 | cut -d'"' -f4`;

if [[ "$email" == "{}" ]]
then
	echo "";
	echo -e "${GREEN} This virtual machine has created under ADMIN account, sorry, but no extra information were found.${NC}";
	echo "";
else
	#connect to api server. the script inside api_server is a select query that gets users datas.
	ssh root@$api_server_ip "/root/script.sh $email" > /root/.tmp.txt;

	#split data from api_server_database. 
	fname=`cat .tmp.txt | cut -d '|' -f1`;
	lname=`cat .tmp.txt | cut -d '|' -f2`;
	nid=`cat .tmp.txt | cut -d '|' -f3`;
	tell=`cat .tmp.txt | cut -d '|' -f4`;
	
	echo"";
	
	echo -e "${GREEN}email:        $email${NC}";
	echo -e "${GREEN}firstname:   $fname${NC}";
	echo -e "${GREEN}surname:     $lname${NC}";
	echo -e "${GREEN}national_id: $nid${NC}";
	echo -e "${GREEN}mobile:      $tell${NC}";
fi

#remove tmp file 
rm -f /root/.tmp.txt

#########################RESULT#############################
#root@controller:~# ./openstack/instance_uuid_to_customer_info.sh
#+--------------------------------------+---------------+----------------------------------+---------+------------+-------------+---------------------------------+
#| ID                                   | Name          | Tenant ID                        | Status  | Task State | Power State | Networks                        |
#+--------------------------------------+---------------+----------------------------------+---------+------------+-------------+---------------------------------+
#| 5e123456-3b66-47d6-b623-93a36a123456 | name1         | xxxxxxxxxxxxxxxxx8yyyyyyyyyyyyyy | SHUTOFF | -          | Running     | net-lan=xxx.xxx.xxx.xxx         |
#| 55123456-0598-46fa-b417-2a8c30123456 | name2         | xxxxxxxxxxxxxxxxxdyyyyyyyyyyyyyy | ACTIVE  | -          | Running     | net-lan=xxx.xxx.xxx.xxx         |
#+--------------------------------------+---------------+----------------------------------+---------+------------+-------------+---------------------------------+
#please input uuid of vm you wish to get user-email-address from:
#
#5e123456-3b66-47d6-b623-93a36a123456
#
#email:        mahdifox2000@mail.com
#firstname:    mahdi
#surname:      bagheri
#national_id:  0987654321
#mobile:       +989376028183
