#bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2021_Apr ##
##########################################

################# Usage ##################
##        run script with script        ##
##########################################

GREEN='\033[0;32m';
NC='\033[0m';

count=`docker images | tail -n+2 | wc -l`;

for ((i=1;i<=$count;i++))
do
	repo=`docker images | tail -n+2 | awk '{print $1}' | awk "NR==$i"`;
	name=`docker images | tail -n+2 | awk "NR==$i"`;
	if [ "$repo" == "<none>" ]
	then
		docker rmi $(docker images  | tail -n+2 | awk '{print $3}' | awk "NR==$i") --force > /dev/null;
		echo -e "${GREEN} REMOVING ${NC} $name ${GREEN} :) ${NC}";
	fi
done
