#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2019_Nov ##
##  Go Programming language Hot Loader  ##
##########################################

################## Usage #################
##  run script from your Terminal via   ##
##  your Project's full path argument   ##
##########################################
if [ -z "$1" ]
then
	echo "Please Specify your Project's full path directory as my first Argument :)"
else
	fullPath=$1
	process_id=`ps -aux | grep "$fullPath" | grep -v "grep" | awk '{print $2}' | awk 'END{ print NR }'`;
	tolerable=2;
	if [ $process_id -eq $tolerable ]server1 | server2 | server3
	then
		echo "starting GoHotLoader script"	
	else
		kill -9 `netstat  -nptl  2>/dev/null | grep "main" | awk '{print $7}' | cut -d "/" -f1`
		kill -9 `ps -aux | grep "$fullPath" | grep -v "grep" | awk '{print $2}'`
	fi
	currentMD5="`find  $fullPath -type f -exec md5sum {} \; | md5sum | awk '{print $1}'`"
	cd $fullPath
   	go run $fullPath/main.go &
	while true
	do
		sleep 3;
		newMD5="`find  $fullPath -type f -exec md5sum {} \; | md5sum | awk '{print $1}'`"
	    	if [ $currentMD5 != $newMD5 ]
		then
			kill -9 `netstat  -nptl  2>/dev/null | grep "main" | awk '{print $7}' | cut -d "/" -f1`
			currentMD5=$newMD5
			go run $fullPath/main.go &
	    	fi
	done
fi
