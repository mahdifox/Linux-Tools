#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2019_Oct ##
##########################################

################## Usage #################
##    run script from your Terminal     ##
##    via start or stop argument        ##
##########################################
case "$1" in
    start)
        process_id=`ps -aux | grep "synchronize_script" | grep -v "grep" | awk '{print $2}' | awk 'END{ print NR }'`;
        tolerable=3;
        if [ $my_var -ge $tolerable ]
        then
            echo "synchronize_script already started !!!";
        else
            while true; do
                sleep 3;
		rsync -az --delete /PathToProjectSource/SpecificFolder1/  /PathToProjectDestination/TheSameSpecificFolder1/;
      		# YOU CAN ADD SpecificFolders AS MANY AS YOU WANT BY ADDING ANOTHER LINE LIKE ABOVE INTO WHILE LOOP.
            done &
            echo "started"
        fi
        ;;
    stop)
        process_id=`ps -aux | grep "synchronize_script" | grep -v "grep" | awk '{print $2}' | awk 'END{ print NR }'`;
        tolerable=2;
        if [ $my_var -eq $tolerable ]
        then
            echo "no synchronize_script started yet";
        else
            kill -9 `ps -aux | grep "synchronize_script" | grep -v "grep" | awk '{print $2}'`
        fi
        ;;
    *)
        echo $"Usage: $0 { start | stop }"
esac
