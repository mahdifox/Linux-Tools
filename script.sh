#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2023_Oct ##
##########################################

################# Usage ##################
##      Run in RC.LOCAL or manual       ##
##########################################

#Define color variable for echo command.
NC='\033[0m';
Red='\033[0;91m';
Green='\033[0;92m';
White='\033[1;97m';
Yellow='\033[0;93m';

#Define MY_PATH variable for future usage.
MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"
if [ -z "$MY_PATH" ] ; then
	echo -e "${RED} PATH NOT FOUND !!! please check file and folders permission${NC}";
	exit 1;
fi

#Creating prerequisite directories
mkdir -p "$MY_PATH/projects";
mkdir -p "$MY_PATH/logs";
now_date=$(date);

#Start Working.
echo -e "\n${Green}Starts${NC}\n";
for directory in $MY_PATH/projects/*
do
			 ### main branch selected for /home/mahdi/omid-script/projects/fum-cloud-frontend directory.

	echo -e "${White}#####################################( START-LOG )############################################${NC}" >> "$MY_PATH/logs/action.log";
	echo -e "${White}$now_date${NC}" >> "$MY_PATH/logs/action.log";

	cd $directory;
	echo -e "${White}###${NC} ${Yellow}select ${NC}${Green}$directory${NC}${Yellow} directory to go with it${NC}" >> "$MY_PATH/logs/action.log";
	echo -e "${White}###${NC} ${Yellow}select ${NC}${Green}$directory${NC} ${Yellow}directory to go with it.${NC}";

	if git branch -a 2>/dev/null| grep master 1>/dev/null; then
		primary="master";
	elif git branch -a 2>/dev/null| grep main 1>/dev/null; then
		primary="main";
	else
		echo -e "${Red}NOT a git repository !!!${NC}"
		continue;
	fi
	echo -e "\n${White}###${NC} ${Green}$primary${NC}${Yellow} branch selected for ${NC}${Green}$directory${NC}${Yellow} directory${NC}" >> "$MY_PATH/logs/action.log";
	echo -e "\n${White}###${NC} ${Green}$primary${NC}${Yellow} branch selected for ${NC}${Green}$directory${NC}${Yellow} directory.${NC}";

	echo -e "\n${White}###${NC} ${Yellow}git checkout${NC}${Green} $primary${NC}${Yellow}:${NC}" >> "$MY_PATH/logs/action.log";
	echo -e "\n${White}###${NC} ${Yellow}git checkout ${NC}${Green}$primary${NC}. ${White}For more details see ${NC}${Green}$MY_PATH/logs/action.log${NC}${White} file.${NC}";
	git checkout $primary >> "$MY_PATH/logs/action.log";

	echo -e "\n${White}###${NC} ${Yellow}git fetch --prune:${NC}" >> "$MY_PATH/logs/action.log";
	echo -e "\n${White}###${NC} ${Yellow}git fetch --prune.${NC} ${White}For more details see ${NC}${Green}$MY_PATH/logs/action.log${NC}${White} file.${NC}";
	git fetch --prune >> "$MY_PATH/logs/action.log";

	echo -e "\n${White}###${NC} ${Yellow}git pull.${NC} ${White}For more details see ${NC}${Green}$MY_PATH/logs/action.log${NC}${White} file.${NC}";
	echo -e "\n${White}###${NC} ${Yellow}git pull:${NC}" >> "$MY_PATH/logs/action.log";
	git pull >> "$MY_PATH/logs/action.log";
	echo "";

	echo -e "${White}##########################################( END-LOG )##########################################${NC}" >> "$MY_PATH/logs/action.log";
done

#End Working.
echo -e "${Green}all done :)\n${NC}";
