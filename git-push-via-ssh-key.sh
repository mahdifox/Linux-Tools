#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2022_Mar ##
##########################################

#define color for print and echo.
NC='\033[0m';         # NO COLOR
GREEN='\033[0;92m';   # Green

echo -e "${GREEN}set git reposity url and test if ssh key is ok:${NC}";
ssh -T git@github.com
git remote set-url origin git@github.com:mahdifox/Linux-Tools.git

echo -e "${GREEN}set global username and email:${NC}"
git config --global user.email "mahdifox2000@gmail.com"
git config --global user.name  "mahdifox"

echo -e "${GREEN}Please set commit message:${NC}"
read commit_message

if [ -z "$commit_message" ]
then
	echo -e "${GREEN} commit message needed !!! :( ${NC}";
	exit;
else
	echo -e "${GREEN}add new changes:${NC}"
	git add -A
	git commit -am "$commit_message"

	echo -e "${GREEN}ok pushing up to master repo${NC}"
	git push
	
	echo -e "${GREEN}done${NC}"
fi
