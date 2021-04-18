#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2021_Apr ##
##           docker(s) auto up          ##
##########################################

#define color for print or echo
GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m';

#api
cd ~/api/;

docker-compose up -d > /dev/null;
if [ $? == 0 ]
then
        echo -e "${GREEN}api docker :)${NC}"
else
        echo -e "${RED}api docker :(${NC}"
fi

#db
cd ~/db/;

docker-compose up -d > /dev/null;
if [ $? == 0 ]
then
        echo -e "${GREEN}db docker :)${NC}"
else
        echo -e "${RED}db docker :(${NC}"
fi

#finance
cd ~/finance-system/;

docker-compose up -d > /dev/null;
if [ $? == 0 ]
then
        echo -e "${GREEN}finance-system docker :)${NC}"
else
        echo -e "${RED}finance-system docker :(${NC}"
fi

#front-end
cd ~/fum-cloud-front/;

docker-compose up -d > /dev/null;
if [ $? == 0 ]
then
        echo -e "${GREEN}fum-cloud-front docker :)${NC}"
else
        echo -e "${RED}fum-cloud-front docker :(${NC}"
fi

#postgresql
cd ~/postgresql/;

docker-compose up -d > /dev/null;
if [ $? == 0 ]
then
        echo -e "${GREEN}postgresql docker :)${NC}"
else
        echo -e "${RED}postgresql docker :(${NC}"
fi

#rabbitmq user(s) docker
cd ~/rabbitmq/;
echo -e "${GREEN}running rabbitmq servers${NC}"

docker-compose -f docker-compose-user1.yml up -d > /dev/null;
if [ $? == 0 ]
then
	echo -e "${GREEN}rabbit user1 :)${NC}"
else
	echo -e "${RED}rabbit user1 :(${NC}"
fi

docker-compose -f docker-compose-user2.yml up -d > /dev/null;
if [ $? == 0 ]
then
	echo -e "${GREEN}rabbit user2 :)${NC}"
else
        echo -e "${RED}rabbit user2 :(${NC}"
fi

docker-compose -f docker-compose-user3.yml up -d > /dev/null;
if [ $? == 0 ]
then
	echo -e "${GREEN}rabbit user3 :)${NC}"
else
        echo -e "${RED}rabbit user3 :(${NC}"
fi
