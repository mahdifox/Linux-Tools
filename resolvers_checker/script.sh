#!/bin/bash

##########################################
## Created_By_Mahdi_Bagheri_at_2020_Aug ##
##        check optimize autorepair     ##
##              in mysql                ##
##########################################

################# Usage ##################
##        run script without args       ##
##       to see all valid arguments     ##
##                                      ##
##       to run one arguments needed    ##
##########################################

# Define path of script for future usage
MY_PATH="`dirname \"$0\"`"                        # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

# Define style and color for printing and logs
BOLD=$(tput bold);
NORMAL=$(tput sgr0);
GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m';

arg1=$1;
if [[ ! -z $arg1 ]]
then
        # Detecting Default network interface
        default_if=`ifconfig  | awk '{print $1}' | head -n1 | cut -d':' -f1`;
        # Deleting DNS1 & DNS2 lines in default network interface file.
        if [ -f "/etc/sysconfig/network-scripts/ifcfg-$default_if" ]
        then
                if grep -q "^DNS" "/etc/sysconfig/network-scripts/ifcfg-$default_if"
                then
                        sed -i '/^DNS/d' "/etc/sysconfig/network-scripts/ifcfg-$default_if";
                fi
        fi

        # Unset readonly permission
        if [ -f "/usr/bin/chattr" ]
        then
                chattr -i "/etc/resolv.conf" 2>/dev/null;
        fi

        # Check user args to see what dns must be inserted in resolv.conf
        case "$arg1" in
                public)
                        rm -rf  "/etc/resolv.conf";
                        echo "# Public Global DNS" >  "/etc/resolv.conf";
                        echo "nameserver 8.8.4.4"  >> "/etc/resolv.conf";
                        echo "nameserver 8.8.8.8"  >> "/etc/resolv.conf";
                        echo "nameserver 1.1.1.1"  >> "/etc/resolv.conf";
                        echo "nameserver 4.2.2.4"  >> "/etc/resolv.conf";
                ;;
                afranet)
                        rm -rf  "/etc/resolv.conf";
                        echo "# Afranet DNS"           >  "/etc/resolv.conf";
                        echo "nameserver 79.175.136.4" >> "/etc/resolv.conf";
                        echo "nameserver 79.175.137.4" >> "/etc/resolv.conf";
                ;;
                pars_online)
                        rm -rf  "/etc/resolv.conf";
                        echo "# ParsOnline DNS"          >  "/etc/resolv.conf";
                        echo "nameserver 213.217.60.170" >> "/etc/resolv.conf";
                        echo "nameserver 213.217.60.172" >> "/etc/resolv.conf";
                ;;
                ovh)
                        rm -rf  "/etc/resolv.conf";
                        echo "# OVH DNS"                >   "/etc/resolv.conf";
                        echo "nameserver 213.186.33.99" >>  "/etc/resolv.conf";
                ;;
                hetzner)
                        rm -rf  "/etc/resolv.conf";
                        echo "# Hetzner DNS"              >  "/etc/resolv.conf";
                        echo "nameserver 213.133.98.98"   >> "/etc/resolv.conf";
                        echo "nameserver 213.133.99.99"   >> "/etc/resolv.conf";
                        echo "nameserver 213.133.100.100" >> "/etc/resolv.conf";
                ;;
                online_net)
                        rm -rf  "/etc/resolv.conf";
                        echo "# OnlineNet DNS"        >  "/etc/resolv.conf";
                        echo "nameserver 62.210.16.6" >> "/etc/resolv.conf";
                        echo "nameserver 62.210.16.7" >> "/etc/resolv.conf";
                ;;
                *)
                        echo -e "${RED}No Argument Passed${NC}, ${BOLD}Please pass one of the arguments bellow${NC}:";
                        echo -e $"Usage: ${GREEN}$0${NC} { ${GREEN}public${NC} | ${GREEN}afranet${NC} | ${GREEN}pars_online${NC} | ${GREEN}ovh${NC} | ${GREEN}hetzner${NC} | ${GREEN}online_net${NC} }";
                        echo -e "${BOLD}example:${NC} ${GREEN}$0 ${BOLD}public${NC}";
        esac
else
        echo -e "${RED}No Argument Passed${NC}, ${BOLD}Please pass one of the arguments bellow${NC}:";
        echo -e $"Usage: ${GREEN}$0${NC} { ${GREEN}public${NC} | ${GREEN}afranet${NC} | ${GREEN}pars_online${NC} | ${GREEN}ovh${NC} | ${GREEN}hetzner${NC} | ${GREEN}online_net${NC} }";
        echo -e "${BOLD}example:${NC} ${GREEN}$0 ${BOLD}public${NC}";
fi
