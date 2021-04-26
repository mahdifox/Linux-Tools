#!/bin/bash

#define color and fonts for print or echo
BOLD=$(tput bold);
NORMAL=$(tput sgr0);
GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m';

HOTSPOT="https://HOTSPOT_URL"

doLogin() {
    response=$(curl -sS "${HOTSPOT}/login" -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H "Origin: ${HOTSPOT}" -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9' -H 'User-Agent: Mozilla/5.0 (compatible; MSIE 10.0; Macintosh; Intel Mac OS X 10_7_3; Trident/6.0)' -H "Referer: ${HOTSPOT}/login" -H 'Accept-Language: en-US,en;q=0.9' --data "dst=&popup=true&username=${1}+&password=${2}");

    if [ $? != 0 ]; then
        echo -e "${RED}Connection to hotspot failed.${NC}"
        exit 1
    elif [[ "${response}" == *"/status"* ]]; then
        echo -e "${GREEN}Connected successfully!${NC}"
    else
        uname=$(echo "${response}" | grep -E -o 'var\s+\$_error\s+=\s+"(.*?)"' | grep -E -o '"(.*?)"' | cut -d '"' -f2 | awk '{print $5}');
        echo -e "${RED}Error:${NC} User with Internet username ${RED}${uname}${NC} does not exists "
        exit 1
    fi
}

doCheckStatus() {
    response=$(curl -s ifconfig.co);
    if [ $? == 0 ]; then
        echo -e "You are ${GREEN}Connected${NC} and your current${GREEN}IP${NC} is: ${BOLD}${response}${NORMAL}"
        exit 1
    else
        echo -e "${RED}Not Connected!${NC}"
        exit 1
    fi;
}

doLogout() {
    response=$(curl -sS "${HOTSPOT}/logout");
    if [ $? != 0 ]; then
        echo -e "${RED}Connection to hotspot failed.${NC}"
        exit 1
    elif [[ "${response}" == *"/login"* ]]; then
        echo -e "${GREEN}Logged out successfully!${NC}"
    else
        echo -e "${RED}Please Login first${NC}"
        exit 1
    fi
}

_md5() {
  if builtin command -v md5 > /dev/null; then
    echo -n "$1" | md5
  elif builtin command -v md5sum > /dev/null ; then
    echo -n "$1" | md5sum | awk '{print $1}'
  else
    rvm_error "Neither md5 nor md5sum were found in the PATH"
    return 1
  fi

  return 0
}

action=$1
if [ -z "$action" ]; then
    echo -e "${BOLD}Usage:${NORMAL}"
    echo -e "    To ${GREEN}log in${NC} run the script as follow:  ${BOLD}./hotspot.sh YOUR_HOTSPOT_USERNAME${NORMAL} (it will ${GREEN}ask${NC} for ${BOLD}YOUR_HOTSPOT_PASSWORD${NORMAL})\n";
    echo -e "    To check ${GREEN}status${NC} run the script as follow: ${BOLD}./hotspot.sh --check-status${NORMAL}\n";
    echo -e "    To ${RED}log out${NC} run the script as follow: ${BOLD}./hotspot.sh --logout${NORMAL}";
    exit 1
elif [ "$action" = "--check-status" ]; then
    doCheckStatus    
elif [ "$action" = "--logout" ]; then
    doLogout
else
    username=$1
    echo -e "Hostpot Username: ${GREEN}$username ${NC}"
    read -sp "Hotspot Password: " password

    printf '\n\n'
    doLogin $username $(_md5 ${password})
fi
