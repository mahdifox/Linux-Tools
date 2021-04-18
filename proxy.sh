#!/bin/bash
##########################################
## Created_By_Mahdi_Bagheri_at_2021_Apr ##
##            http/https proxy          ##
##########################################

################# Usage ##################
##    run script with start / stop,     ##
##        i.e., ./proxy.sh start        ##
##########################################

GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m';

case "$1" in
	start)
		export HTTP_PROXY=<USER>:<PASSWORD>@<PROXY_SERVER_IP>:<PROXY_SERVER_PORT>;
		export HTTPS_PROXY=<USER>:<PASSWORD>@<PROXY_SERVER_IP>:<PROXY_SERVER_PORT>;
		echo -e " ${GREEN}http/s proxy connected :)${NC}";
        	;;
	stop)
		export HTTP_PROXY="";
		export HTTPS_PROXY="";
		echo "${RED}http/s disconnected :)${NC}";
        	;;
	*)
        	echo -e $"Usage: $0 { ${GREEN}start${NC} | ${RED}stop${NC} }"
esac
