#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2021_Mar ##
##            haproxy builder           ##
##########################################

#define color for print or echo
GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m';

echo -e "${GREEN}Building linux-haproxy${NC}"
docker build -t linux-haproxy .

echo -e "${GREEN}Checking linux-haproxy Config file inside the Container${NC}"
docker run -it --rm --name haproxy-syntax-check linux-haproxy haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg > /root/filetest;
if grep -Fq "file is valid" /root/testfile
	then 
		echo "ok"
		echo -e "${GREEN}Removing old Container(s)${NC}"
		docker container rm $(docker ps -aq) --force

		echo -e "${GREEN}Create new Container based on config file${NC}"
	       	docker run -d --network host --name linux-haproxy linux-haproxy
		echo -e "you are all set. happy exploring ${GREEN} :) ${NC}"
else
	echo -e "${RED}Config file is not valid${NC}"
fi
rm -f /root/filetest
